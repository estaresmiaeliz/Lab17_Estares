<?php
// db.php - reuse this file for DB connection
$host = 'localhost';
$db   = 'salecodb';
$user = 'root';        // default XAMPP MySQL user
$pass = '';            // default XAMPP MySQL password (empty)
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    // In production do not echo raw errors. For development this is fine.
    echo "Database connection failed: " . $e->getMessage();
    exit;
}
