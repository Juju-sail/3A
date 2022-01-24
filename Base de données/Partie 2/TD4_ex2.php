<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Liste acteurs</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="https://pagecdn.io/lib/semantic-ui/2.4.1/semantic.min.css">
    <?php

        function getPDO (): PDO {
            $host = 'localhost';
            $dbname = 'cinema';
            $dsn = 'mysql:host=' . $host . ';dbname=' . $dbname . ';charset=utf8';
            $username = 'root';
            $passwd = 'root';

            try {
                $pdo = new PDO($dsn, $username, $passwd);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                return $pdo;
            } catch (PDOException $e) {
                die($e->getMessage());
            }
        }

        function getActeurs (PDO $pdo): PDOStatement {
            $sql = 'SELECT nom, prenom, date_naiss FROM acteurs';
            return $pdo->query($sql);
        }

    ?>
</head>
<body>
<div class="ui one column centered grid">
    <div class="column">
        <table class="ui celled table">
            <thead>
            <tr>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Date naissance</th>
            </tr>
            </thead>
            <tbody>
            <?php
                $acteurs = getActeurs(getPDO());
                foreach ($acteurs as $acteur) {
                    ?>
                    <tr>
                        <td>
                            <?= $acteur['nom'] ?>
                        </td>
                        <td>
                            <?= $acteur['prenom'] ?>
                        </td>
                        <td>
                            <?= $acteur['date_naiss'] ?>
                        </td>
                    </tr>
                    <?php
                }
            ?>
            </tbody>
        </table>
    </div>
</div>
<script
    src="https://code.jquery.com/jquery-3.1.1.min.js"
    integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
    crossorigin="anonymous"></script>
<script src="https://pagecdn.io/lib/semantic-ui/2.4.1/semantic.min.js"></script>
</body>
</html>
