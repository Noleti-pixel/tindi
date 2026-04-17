<?php
// Enable CORS for Flutter app
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json; charset=utf-8');

// Database configuration
$servername = "localhost";
$username = "root";           // Change this to your database username
$password = "";               // Change this to your database password
$database = "acs314a";        // Change this to your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(["error" => "Database connection failed: " . $conn->connect_error]));
}

// Set charset to utf8
$conn->set_charset("utf8");

// Get all clothes from database
$sql = "SELECT id, name, size, price, image, category FROM clothes";
$result = $conn->query($sql);

$clothes = [];

if ($result && $result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        // Parse sizes - if stored as JSON, decode it; otherwise create array
        $sizes = [];
        if (!empty($row["size"])) {
            // If sizes are stored as JSON string
            if (strpos($row["size"], '[') === 0) {
                $sizes = json_decode($row["size"], true);
            } else {
                // If stored as comma-separated or single value
                $sizes = array_filter(array_map('trim', explode(',', $row["size"])));
                if (empty($sizes)) {
                    $sizes = ["One Size"];
                }
            }
        } else {
            $sizes = ["One Size"];
        }

        // Handle image URL - construct full path for local images
        $imageUrl = $row["image"];
        if (!empty($imageUrl)) {
            // If it's not already a full URL (doesn't start with http)
            if (strpos($imageUrl, 'http') !== 0) {
                // Treat it as a filename and prepend the full path
                $imageUrl = "http://localhost/clothes_api/images/" . rawurlencode($imageUrl);
            }
        } else {
            // Fallback to placeholder if no image
            $imageUrl = "https://via.placeholder.com/300?text=" . urlencode($row["name"]);
        }

        $clothes[] = [
            "id" => (int)$row["id"],
            "name" => $row["name"],
            "price" => (int)$row["price"],
            "image" => $imageUrl,
            "category" => $row["category"],
            "sizes" => $sizes
        ];
    }
}

// Return JSON response
http_response_code(200);
echo json_encode($clothes);

// Close connection
$conn->close();
?>
