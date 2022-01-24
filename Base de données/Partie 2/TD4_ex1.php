<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Tables de multiplication</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/foundation-sites@6.6.3/dist/css/foundation.min.css" integrity="sha256-ogmFxjqiTMnZhxCqVmcqTvjfe1Y/ec4WaRj/aQPvn+I=" crossorigin="anonymous">
</head>
<body>
<h3>Tables de multiplication :</h3>
<table>
    <?php
    for ($i = 1; $i <= 10; $i++) {
        ?>
        <tr>
            <?php
            for ($j = 1; $j <= 10; $j++) {
                ?>
                <td><?= $i * $j ?></td>
                <?php
            }
            ?>
        </tr>
        <?php
    }
    ?>
    <tr></tr>
</table>
<script src="https://cdn.jsdelivr.net/npm/foundation-sites@6.6.3/dist/js/foundation.min.js" integrity="sha256-pRF3zifJRA9jXGv++b06qwtSqX1byFQOLjqa2PTEb2o=" crossorigin="anonymous"></script>
</body>
</html>
