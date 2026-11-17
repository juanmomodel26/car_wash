<html>

<head>
    <meta charset="utf-8">
    <title>car wash</title>
    <link href="../style.css" rel="stylesheet">
</head>

<body>
    <header>
        <nav class="navbar">
            <a href="../index.php">Retourner a l'accueil</a>
        </nav>
    </header>

    <form method="POST">
        <input type="text" name="nom" placeholder="nom">
        <input type="text" name="prenom" placeholder="prenom">
        <input type="text" name="adresse" placeholder="adresse">
        <input type="text" name="tel" placeholder="Télephone">
        <input type="email" name="email" placeholder="email">
        <label for="prestation">Choisissez une prestation :</label>
        <select name="prestation" id="prestation" required>
            <option value="1">Produit</option>
            <option value="2">Prestation</option>
        </select>
    </form>

</body>