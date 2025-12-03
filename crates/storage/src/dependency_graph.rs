use std::collections::{HashMap, HashSet};

#[derive(Debug, Clone, Default)]
pub struct DependencyGraph {
    children: HashMap<String, Vec<(String, String)>>,
    parents: HashMap<String, Vec<(String, String)>>,
}

impl DependencyGraph {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn add_foreign_key(
        &mut self,
        child_table: String,
        parent_table: String,
        constraint_name: String,
    ) {
        self.children
            .entry(parent_table.clone())
            .or_default()
            .push((child_table.clone(), constraint_name.clone()));

        self.parents
            .entry(child_table)
            .or_default()
            .push((parent_table, constraint_name));
    }

    pub fn remove_foreign_key(&mut self, child_table: &str, constraint_name: &str) {
        for children_list in self.children.values_mut() {
            children_list.retain(|(child, name)| child != child_table || name != constraint_name);
        }

        if let Some(parents_list) = self.parents.get_mut(child_table) {
            parents_list.retain(|(_, name)| name != constraint_name);
        }
    }

    pub fn get_children(&self, parent_table: &str) -> Vec<(String, String)> {
        self.children.get(parent_table).cloned().unwrap_or_default()
    }

    pub fn get_parents(&self, child_table: &str) -> Vec<(String, String)> {
        self.parents.get(child_table).cloned().unwrap_or_default()
    }

    pub fn has_children(&self, table: &str) -> bool {
        self.children
            .get(table)
            .map(|children| !children.is_empty())
            .unwrap_or(false)
    }

    pub fn has_parents(&self, table: &str) -> bool {
        self.parents
            .get(table)
            .map(|parents| !parents.is_empty())
            .unwrap_or(false)
    }

    pub fn would_create_cycle(&self, child_table: &str, parent_table: &str) -> bool {
        if child_table == parent_table {
            return false;
        }

        self.can_reach_through_parents(child_table, parent_table)
    }

    fn can_reach_through_parents(&self, source: &str, target: &str) -> bool {
        let mut visited = HashSet::new();
        let mut stack = vec![source.to_string()];

        while let Some(current) = stack.pop() {
            if visited.contains(&current) {
                continue;
            }
            visited.insert(current.clone());

            if let Some(parents) = self.parents.get(&current) {
                for (parent, _) in parents {
                    if parent == target {
                        return true;
                    }
                    if !visited.contains(parent) {
                        stack.push(parent.clone());
                    }
                }
            }
        }

        false
    }

    pub fn remove_table(&mut self, table_name: &str) {
        self.children.remove(table_name);
        self.parents.remove(table_name);

        for children_list in self.children.values_mut() {
            children_list.retain(|(child, _)| child != table_name);
        }

        for parents_list in self.parents.values_mut() {
            parents_list.retain(|(parent, _)| parent != table_name);
        }
    }

    pub fn get_all_dependents(&self, table: &str) -> Vec<String> {
        self.collect_reachable_nodes(table, |graph, current| {
            graph
                .children
                .get(current)
                .map(|children| children.iter().map(|(child, _)| child.clone()).collect())
                .unwrap_or_default()
        })
    }

    fn collect_reachable_nodes<G>(&self, start: &str, get_neighbors: G) -> Vec<String>
    where
        G: Fn(&Self, &str) -> Vec<String>,
    {
        let mut result = Vec::new();
        let mut visited = HashSet::new();
        let mut stack = vec![start.to_string()];

        while let Some(current) = stack.pop() {
            if visited.contains(&current) {
                continue;
            }
            visited.insert(current.clone());

            if current != start {
                result.push(current.clone());
            }

            for neighbor in get_neighbors(self, &current) {
                if !visited.contains(&neighbor) {
                    stack.push(neighbor);
                }
            }
        }

        result
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add_foreign_key() {
        let mut graph = DependencyGraph::new();
        graph.add_foreign_key(
            "employees".to_string(),
            "departments".to_string(),
            "fk_emp_dept".to_string(),
        );

        assert!(graph.has_children("departments"));
        assert!(graph.has_parents("employees"));
        assert!(!graph.has_children("employees"));
    }

    #[test]
    fn test_get_children() {
        let mut graph = DependencyGraph::new();
        graph.add_foreign_key(
            "employees".to_string(),
            "departments".to_string(),
            "fk1".to_string(),
        );
        graph.add_foreign_key(
            "projects".to_string(),
            "departments".to_string(),
            "fk2".to_string(),
        );

        let children = graph.get_children("departments");
        assert_eq!(children.len(), 2);
        assert!(children.iter().any(|(child, _)| child == "employees"));
        assert!(children.iter().any(|(child, _)| child == "projects"));
    }

    #[test]
    fn test_circular_dependency_detection() {
        let mut graph = DependencyGraph::new();

        graph.add_foreign_key("b".to_string(), "a".to_string(), "fk1".to_string());
        graph.add_foreign_key("c".to_string(), "b".to_string(), "fk2".to_string());

        assert!(graph.would_create_cycle("c", "a"));

        assert!(!graph.would_create_cycle("c", "d"));
    }

    #[test]
    fn test_self_referencing_allowed() {
        let graph = DependencyGraph::new();

        assert!(!graph.would_create_cycle("employees", "employees"));
    }

    #[test]
    fn test_remove_table() {
        let mut graph = DependencyGraph::new();
        graph.add_foreign_key(
            "employees".to_string(),
            "departments".to_string(),
            "fk1".to_string(),
        );

        graph.remove_table("employees");

        assert!(!graph.has_children("departments"));
        assert!(!graph.has_parents("employees"));
    }

    #[test]
    fn test_get_all_dependents() {
        let mut graph = DependencyGraph::new();

        graph.add_foreign_key(
            "employees".to_string(),
            "departments".to_string(),
            "fk1".to_string(),
        );
        graph.add_foreign_key(
            "projects".to_string(),
            "employees".to_string(),
            "fk2".to_string(),
        );

        let dependents = graph.get_all_dependents("departments");
        assert_eq!(dependents.len(), 2);
        assert!(dependents.contains(&"employees".to_string()));
        assert!(dependents.contains(&"projects".to_string()));
    }
}
