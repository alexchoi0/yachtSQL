mod common;

use common::{get_f64, get_string, is_null};
use yachtsql::{DialectType, QueryExecutor};

fn create_executor() -> QueryExecutor {
    QueryExecutor::with_dialect(DialectType::PostgreSQL)
}

fn get_bool(result: &yachtsql::RecordBatch, col: usize, row: usize) -> bool {
    result
        .column(col)
        .unwrap()
        .get(row)
        .unwrap()
        .as_bool()
        .expect("Expected bool value")
}

mod point_type {
    use super::*;

    #[test]
    fn test_point_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT POINT '(1, 2)' as p")
            .expect("POINT literal should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "POINT should not return NULL - point type not implemented"
        );
    }

    #[test]
    fn test_point_constructor() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(3.5, 4.5) as p")
            .expect("point() constructor should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "point() should not return NULL - point constructor not implemented"
        );
    }

    #[test]
    fn test_point_display() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(1.0, 2.0)::TEXT as p")
            .expect("point cast to TEXT should work");

        assert_eq!(result.num_rows(), 1);
        let text = get_string(&result, 0, 0);
        assert_eq!(text, "(1,2)", "Point should display as (x,y)");
    }

    #[test]
    fn test_point_with_negative_coords() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(-1.5, -2.5) as p")
            .expect("point with negative coords should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_point_with_zero() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(0, 0) as origin")
            .expect("origin point should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }
}

mod box_type {
    use super::*;

    #[test]
    fn test_box_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT BOX '((0,0),(1,1))' as b")
            .expect("BOX literal should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "BOX should not return NULL - box type not implemented"
        );
    }

    #[test]
    fn test_box_constructor_from_points() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT box(point(0,0), point(2,3)) as b")
            .expect("box(point, point) constructor should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "box() should not return NULL - box constructor not implemented"
        );
    }

    #[test]
    fn test_box_constructor_from_coords() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT box(point(0,0), point(2,3)) as b")
            .expect("box with coords should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_box_area() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT area(box(point(0,0), point(3,4))) as a")
            .expect("area(box) should work");

        assert_eq!(result.num_rows(), 1);
        let area = get_f64(&result, 0, 0);
        assert!((area - 12.0).abs() < 0.0001, "area of 3x4 box should be 12");
    }

    #[test]
    fn test_box_center() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT center(box(point(0,0), point(4,4)))::TEXT as c")
            .expect("center(box) should work");

        assert_eq!(result.num_rows(), 1);
        let text = get_string(&result, 0, 0);
        assert_eq!(text, "(2,2)", "center of (0,0)-(4,4) box should be (2,2)");
    }

    #[test]
    fn test_box_width_height() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT width(box(point(1,2), point(5,7))) as w, height(box(point(1,2), point(5,7))) as h")
            .expect("width/height should work");

        assert_eq!(result.num_rows(), 1);
        let width = get_f64(&result, 0, 0);
        let height = get_f64(&result, 1, 0);
        assert!((width - 4.0).abs() < 0.0001, "width should be 4");
        assert!((height - 5.0).abs() < 0.0001, "height should be 5");
    }
}

mod circle_type {
    use super::*;

    #[test]
    fn test_circle_literal() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT CIRCLE '<(0,0),5>' as c")
            .expect("CIRCLE literal should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "CIRCLE should not return NULL - circle type not implemented"
        );
    }

    #[test]
    fn test_circle_constructor() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT circle(point(0,0), 5) as c")
            .expect("circle(point, radius) constructor should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(
            !is_null(&result, 0, 0),
            "circle() should not return NULL - circle constructor not implemented"
        );
    }

    #[test]
    fn test_circle_from_coords() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT circle(point(3, 4), 2.5) as c")
            .expect("circle with coords should parse");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_circle_area() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT area(circle(point(0,0), 1)) as a")
            .expect("area(circle) should work");

        assert_eq!(result.num_rows(), 1);
        let area = get_f64(&result, 0, 0);

        assert!(
            (area - std::f64::consts::PI).abs() < 0.0001,
            "area of unit circle should be pi"
        );
    }

    #[test]
    fn test_circle_center() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT center(circle(point(3,4), 5))::TEXT as c")
            .expect("center(circle) should work");

        assert_eq!(result.num_rows(), 1);
        let text = get_string(&result, 0, 0);
        assert_eq!(text, "(3,4)", "center of circle should be (3,4)");
    }

    #[test]
    fn test_circle_diameter() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT diameter(circle(point(0,0), 7)) as d")
            .expect("diameter(circle) should work");

        assert_eq!(result.num_rows(), 1);
        let diameter = get_f64(&result, 0, 0);
        assert!((diameter - 14.0).abs() < 0.0001, "diameter should be 14");
    }

    #[test]
    fn test_circle_radius() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT radius(circle(point(0,0), 3.5)) as r")
            .expect("radius(circle) should work");

        assert_eq!(result.num_rows(), 1);
        let radius = get_f64(&result, 0, 0);
        assert!((radius - 3.5).abs() < 0.0001, "radius should be 3.5");
    }
}

mod distance_operator {
    use super::*;

    #[test]
    fn test_point_to_point_distance() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(0,0) <-> point(3,4) as d")
            .expect("point <-> point should work");

        assert_eq!(result.num_rows(), 1);
        let distance = get_f64(&result, 0, 0);
        assert!(
            (distance - 5.0).abs() < 0.0001,
            "distance from origin to (3,4) should be 5"
        );
    }

    #[test]
    fn test_point_to_point_distance_same_point() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(5,5) <-> point(5,5) as d")
            .expect("distance between same points should work");

        assert_eq!(result.num_rows(), 1);
        let distance = get_f64(&result, 0, 0);
        assert!(
            (distance - 0.0).abs() < 0.0001,
            "distance between same points should be 0"
        );
    }

    #[test]
    fn test_point_to_circle_distance() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(10,0) <-> circle(point(0,0), 3) as d")
            .expect("point <-> circle should work");

        assert_eq!(result.num_rows(), 1);
        let distance = get_f64(&result, 0, 0);

        assert!((distance - 7.0).abs() < 0.0001, "distance should be 7");
    }

    #[test]
    fn test_circle_to_circle_distance() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT circle(point(0,0), 2) <-> circle(point(10,0), 3) as d")
            .expect("circle <-> circle should work");

        assert_eq!(result.num_rows(), 1);
        let distance = get_f64(&result, 0, 0);

        assert!((distance - 5.0).abs() < 0.0001, "distance should be 5");
    }
}

mod containment_operators {
    use super::*;

    #[test]
    fn test_box_contains_point() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT box(point(0,0), point(10,10)) @> point(5,5) as contains")
            .expect("box @> point should work");

        assert_eq!(result.num_rows(), 1);
        let contains = get_bool(&result, 0, 0);
        assert!(contains, "box (0,0)-(10,10) should contain point (5,5)");
    }

    #[test]
    fn test_box_does_not_contain_point() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT box(point(0,0), point(10,10)) @> point(15,15) as contains")
            .expect("box @> point should work");

        assert_eq!(result.num_rows(), 1);
        let contains = get_bool(&result, 0, 0);
        assert!(
            !contains,
            "box (0,0)-(10,10) should NOT contain point (15,15)"
        );
    }

    #[test]
    fn test_point_contained_by_box() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(5,5) <@ box(point(0,0), point(10,10)) as contained")
            .expect("point <@ box should work");

        assert_eq!(result.num_rows(), 1);
        let contained = get_bool(&result, 0, 0);
        assert!(
            contained,
            "point (5,5) should be contained by box (0,0)-(10,10)"
        );
    }

    #[test]
    fn test_circle_contains_point() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT circle(point(0,0), 10) @> point(3,4) as contains")
            .expect("circle @> point should work");

        assert_eq!(result.num_rows(), 1);
        let contains = get_bool(&result, 0, 0);

        assert!(
            contains,
            "circle with radius 10 should contain point at distance 5"
        );
    }

    #[test]
    fn test_boxes_overlap() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT box(point(0,0), point(5,5)) && box(point(3,3), point(8,8)) as overlaps",
            )
            .expect("box && box should work");

        assert_eq!(result.num_rows(), 1);
        let overlaps = get_bool(&result, 0, 0);
        assert!(overlaps, "boxes (0,0)-(5,5) and (3,3)-(8,8) should overlap");
    }

    #[test]
    fn test_boxes_do_not_overlap() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql(
                "SELECT box(point(0,0), point(2,2)) && box(point(5,5), point(8,8)) as overlaps",
            )
            .expect("box && box should work");

        assert_eq!(result.num_rows(), 1);
        let overlaps = get_bool(&result, 0, 0);
        assert!(
            !overlaps,
            "boxes (0,0)-(2,2) and (5,5)-(8,8) should NOT overlap"
        );
    }

    #[test]
    fn test_circles_overlap() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT circle(point(0,0), 5) && circle(point(8,0), 5) as overlaps")
            .expect("circle && circle should work");

        assert_eq!(result.num_rows(), 1);
        let overlaps = get_bool(&result, 0, 0);

        assert!(overlaps, "circles should overlap");
    }
}

mod table_operations {
    use super::*;

    #[test]
    fn test_create_table_with_point_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE locations (id INT, pos POINT)")
            .expect("CREATE TABLE with POINT column should work");

        executor
            .execute_sql("INSERT INTO locations VALUES (1, point(10.5, 20.5))")
            .expect("INSERT with point value should work");

        let result = executor
            .execute_sql("SELECT pos FROM locations WHERE id = 1")
            .expect("SELECT with point column should work");

        assert_eq!(result.num_rows(), 1);
        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_create_table_with_box_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE regions (id INT, bounds BOX)")
            .expect("CREATE TABLE with BOX column should work");

        executor
            .execute_sql("INSERT INTO regions VALUES (1, box(point(0,0), point(100,100)))")
            .expect("INSERT with box value should work");

        let result = executor
            .execute_sql("SELECT area(bounds) FROM regions WHERE id = 1")
            .expect("SELECT with box function should work");

        assert_eq!(result.num_rows(), 1);
        let area = get_f64(&result, 0, 0);
        assert!((area - 10000.0).abs() < 0.0001, "area should be 10000");
    }

    #[test]
    fn test_create_table_with_circle_column() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE zones (id INT, zone CIRCLE)")
            .expect("CREATE TABLE with CIRCLE column should work");

        executor
            .execute_sql("INSERT INTO zones VALUES (1, circle(point(50, 50), 25))")
            .expect("INSERT with circle value should work");

        let result = executor
            .execute_sql("SELECT radius(zone) FROM zones WHERE id = 1")
            .expect("SELECT with circle function should work");

        assert_eq!(result.num_rows(), 1);
        let radius = get_f64(&result, 0, 0);
        assert!((radius - 25.0).abs() < 0.0001, "radius should be 25");
    }

    #[test]
    fn test_filter_by_distance() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE places (name TEXT, location POINT)")
            .expect("CREATE TABLE should work");

        executor
            .execute_sql(
                "INSERT INTO places VALUES ('A', point(0,0)), ('B', point(3,4)), ('C', point(10,10))",
            )
            .expect("INSERT should work");

        let result = executor
            .execute_sql("SELECT name FROM places WHERE location <-> point(0,0) < 6")
            .expect("Distance filter should work");

        assert_eq!(result.num_rows(), 2);
    }

    #[test]
    fn test_filter_by_containment() {
        let mut executor = create_executor();

        executor
            .execute_sql("CREATE TABLE items (name TEXT, pos POINT)")
            .expect("CREATE TABLE should work");

        executor
            .execute_sql(
                "INSERT INTO items VALUES ('inside', point(5,5)), ('outside', point(15,15))",
            )
            .expect("INSERT should work");

        let result = executor
            .execute_sql("SELECT name FROM items WHERE pos <@ box(point(0,0), point(10,10))")
            .expect("Containment filter should work");

        assert_eq!(result.num_rows(), 1);
        let name = get_string(&result, 0, 0);
        assert_eq!(name, "inside");
    }
}

mod edge_cases {
    use super::*;

    #[test]
    fn test_point_with_infinity() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point('Infinity', 0) as p")
            .expect("point with infinity should work");

        assert_eq!(result.num_rows(), 1);

        assert!(!is_null(&result, 0, 0));
    }

    #[test]
    fn test_point_with_nan() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point('NaN', 'NaN') as p")
            .expect("point with NaN should work");

        assert_eq!(result.num_rows(), 1);
    }

    #[test]
    fn test_null_point() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT point(NULL, 1) as p")
            .expect("point with NULL should work");

        assert_eq!(result.num_rows(), 1);

        assert!(
            is_null(&result, 0, 0),
            "point with NULL coord should be NULL"
        );
    }

    #[test]
    fn test_circle_with_zero_radius() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT area(circle(point(0,0), 0)) as a")
            .expect("circle with zero radius should work");

        assert_eq!(result.num_rows(), 1);
        let area = get_f64(&result, 0, 0);
        assert!(
            (area - 0.0).abs() < 0.0001,
            "area of zero-radius circle should be 0"
        );
    }

    #[test]
    fn test_circle_with_negative_radius() {
        let mut executor = create_executor();

        let result = executor.execute_sql("SELECT circle(point(0,0), -5) as c");

        match result {
            Ok(batch) => {
                assert_eq!(batch.num_rows(), 1);
            }
            Err(e) => {
                assert!(e.to_string().contains("negative") || e.to_string().contains("invalid"));
            }
        }
    }

    #[test]
    fn test_box_with_same_corners() {
        let mut executor = create_executor();

        let result = executor
            .execute_sql("SELECT area(box(point(5,5), point(5,5))) as a")
            .expect("degenerate box should work");

        assert_eq!(result.num_rows(), 1);
        let area = get_f64(&result, 0, 0);
        assert!((area - 0.0).abs() < 0.0001, "area of point-box should be 0");
    }
}
