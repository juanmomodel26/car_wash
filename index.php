<html>

<head>
    <meta charset="utf-8">
    <title>car wash</title>
    <link href="style.css" rel="stylesheet">
</head>

<body>
    <header>
        <nav class="navbar">
            <a href="../frontend/gen_devis.php">Réaliser mon devis</a>
            <div class="dropdown">
                <button class="dropbutton">Services</button>
                <div class="dropdown-content">
                    <a href="#produits">produits</a>
                    <a href="#prestations">prestations</a>
                </div>
            </div>
        </nav>
    </header>
    <!-- ////////////////////////////////////////////////////////////////////////// tableau Produits ////////////////////////////////////////////////////////////////////////// -->
    <h2 id="produits">Produits</h2>
    <?php
    $bdd = new PDO('mysql:host=localhost;dbname=projet_lavage;charset=utf8', 'root', 'caribou');
    $stmt = $bdd->prepare("select * from produits;");

    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    <table>
        <thead>
            <tr>
                <th>nom</th>
                <th>categorie</th>
                <th>caracteristiques</th>
                <th>prix unitée</th>
                <th>informations supplémentaires</th>

            </tr>
        </thead>
        <tbody>
            <?php foreach ($result as $ligne) { ?>
                <tr>

                    <td><?= $ligne['nom'] ?></td>
                    <td><?= $ligne['categorie'] ?></td>
                    <td><?= $ligne['caracteristiques'] ?></td>
                    <td><?= $ligne['prix'] ?></td>
                    <td><?= $ligne['description_devis'] ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>

    <!-- ////////////////////////////////////////////////////////////////////////// tableau coffrets ////////////////////////////////////////////////////////////////////////// -->

    <h2>Coffrets</h2>

    <?php
    $bdd = new PDO('mysql:host=localhost;dbname=projet_lavage;charset=utf8', 'root', 'caribou');
    $stmt = $bdd->prepare("SELECT p.nom AS coffret, c.nom AS composant, cc.coffret_id AS id_coffret FROM produits p, composition_coffret cc, composants c WHERE cc.coffret_id = p.id AND c.id = cc.composant_id ORDER BY p.id, c.id;");

    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $coffrets = [];
    foreach ($result as $ligne) {
        $id = $ligne['id_coffret'];
        $coffrets[$id]['nom'] = $ligne['coffret'];
        $coffrets[$id]['composants'][] = $ligne['composant'];
    }
    ?>
    <table>
        <thead>
            <tr>
                <th>nom</th>
                <th>Composition</th>

            </tr>
        </thead>
        <tbody>
            <?php foreach ($coffrets as $coffret) { ?>
                <tr>
                    <td><?= $coffret['nom'] ?></td>
                    <td>
                        <ul>
                            <?php foreach ($coffret['composants'] as $composant) { ?>
                                <li><?= $composant ?></li>
                            <?php } ?>
                        </ul>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>

    <!-- ////////////////////////////////////////////////////////////////////////// tableau prestations ////////////////////////////////////////////////////////////////////////// -->

    <h2 id="prestations">Prestations</h2>
    <?php
    $bdd = new PDO('mysql:host=localhost;dbname=projet_lavage;charset=utf8', 'root', 'caribou');
    $stmt = $bdd->prepare("select * from prestations;");

    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    ?>
    <table>
        <thead>
            <tr>
                <th>nom</th>
                <th>caracteristiques</th>
                <th>detail service</th>

                <th>prix unitée</th>
                <th>informations supplémentaires</th>

            </tr>
        </thead>
        <tbody>
            <?php foreach ($result as $ligne) { ?>
                <tr>
                    <td><?= $ligne['nom'] ?></td>
                    <td><?= $ligne['caracteristiques'] ?></td>
                    <td><?= $ligne['detail_service'] ?></td>
                    <td><?= $ligne['prix'] ?></td>
                    <td><?= $ligne['description_devis'] ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
</body>

</html>