<?php
// Database connection details
$servername = "your_mysql_server";
$username = "your_mysql_username";
$password = "your_mysql_password";
$dbname = "your_mysql_database";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch data from the database (you need to customize this based on your requirements)

// Fetch services
$servicesSql = "SELECT * FROM Services";
$servicesResult = $conn->query($servicesSql);

// Fetch team members
$teamSql = "SELECT * FROM TeamMembers";
$teamResult = $conn->query($teamSql);

// Fetch testimonials
$testimonialsSql = "SELECT * FROM Testimonials";
$testimonialsResult = $conn->query($testimonialsSql);

// Display the fetched data

// Display services
if ($servicesResult->num_rows > 0) {
    echo "<h2>Our Services</h2>";
    while ($service = $servicesResult->fetch_assoc()) {
        echo "<div class='service'>";
        echo "<img src='img/services/{$service['Image']}' alt='{$service['ServiceName']}'>";
        echo "<div class='service-details'>";
        echo "<h3>{$service['ServiceName']}</h3>";
        echo "<p>{$service['Description']}</p>";
        echo "</div>";
        echo "</div>";
    }
} else {
    echo "No services found.";
}

// Display team members
if ($teamResult->num_rows > 0) {
    echo "<h2>Meet Our Team</h2>";
    while ($member = $teamResult->fetch_assoc()) {
        echo "<div class='team-member'>";
        echo "<img src='img/team/{$member['Image']}' alt='{$member['Name']}'>";
        echo "<div class='member-details'>";
        echo "<h3>{$member['Name']}</h3>";
        echo "<p>{$member['Position']}</p>";
        echo "</div>";
        echo "</div>";
    }
} else {
    echo "No team members found.";
}

// Display testimonials
if ($testimonialsResult->num_rows > 0) {
    echo "<h2>What Our Patients Say</h2>";
    while ($testimonial = $testimonialsResult->fetch_assoc()) {
        echo "<div class='testimonial'>";
        echo "<blockquote>{$testimonial['Comment']}</blockquote>";
        echo "<p class='author'>- {$testimonial['Author']}</p>";
        echo "</div>";
    }
} else {
    echo "No testimonials found.";
}

// Close the database connection
$conn->close();
?>
