<?php
require_once 'db.php';
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Orders - Product Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { padding: 20px; }
    table th, table td { vertical-align: middle; }
  </style>
</head>
<body>
  <nav class="navbar navbar-dark bg-primary mb-3">
    <a class="navbar-brand text-white" href="dashboard.html">Product Management</a>
  </nav>

  <div class="container-fluid">
    <h1 class="h3 mb-3">Orders</h1>

    <div class="table-responsive">
      <table class="table table-striped table-bordered">
        <thead class="thead-dark">
          <tr>
            <th>Invoice #</th>
            <th>Customer Name</th>
            <th>Date</th>
            <th class="text-right">Sub Total</th>
            <th class="text-right">Tax</th>
            <th class="text-right">Total</th>
          </tr>
        </thead>
        <tbody>
        <?php
        // Query invoices joined with customer
        $sql = "SELECT i.invoice_id, c.customer_name, i.invoice_date, i.subtotal, i.tax, i.total
                FROM invoice i
                JOIN customer c ON i.customer_id = c.customer_id
                ORDER BY i.invoice_date DESC, i.invoice_id DESC";
        $stmt = $pdo->query($sql);

        while ($row = $stmt->fetch()) {
            // Format date: dd MMM yyyy (e.g. 11 NOV 2025)
            $dateObj = DateTime::createFromFormat('Y-m-d', $row['invoice_date']);
            $formattedDate = $dateObj ? strtoupper($dateObj->format('d M Y')) : $row['invoice_date'];
            // Because 'M' gives 'Nov' — we use strtoupper to get 'NOV'. Example output: 11 NOV 2025
            $formattedDate = str_replace('.', '', $formattedDate); // remove any dots

            echo "<tr>";
            echo "<td>{$row['invoice_id']}</td>";
            echo "<td>" . htmlspecialchars($row['customer_name']) . "</td>";
            echo "<td>{$formattedDate}</td>";
            echo "<td class='text-right'>" . number_format($row['subtotal'], 2) . "</td>";
            echo "<td class='text-right'>" . number_format($row['tax'], 2) . "</td>";
            echo "<td class='text-right'>" . number_format($row['total'], 2) . "</td>";
            echo "</tr>";
        }
        ?>
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="css/bootstrap.min.js"></script>
</body>
</html>
