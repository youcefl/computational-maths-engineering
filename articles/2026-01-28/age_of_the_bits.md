# Le nombre de bits d’information produit par l’Homme depuis le 01.01.1946, ordre de grandeur et considérations technico-philosophiques liées

Note: ce texte a été entièrement écrit par un humain, l’IA n’a fait que le relire et proposer des corrections mineures.

Dans mon précédent post (visible [ici](https://github.com/youcefl/computational-maths-engineering/blob/8e8671dfcb6022d1876925e1c0f3a7250a2ca633/articles/2026-01-27/deep_impact_(1998).md) ou [ici](https://www.linkedin.com/posts/youcef-l-9b125b44_quand-morgan-freeman-donne-le-bon-ordre-de-activity-7421899882849865728-KvPo?utm_source=share&utm_medium=member_desktop&rcm=ACoAAAlKvNUB1h1isixN0dJPfO3i0PG2mx4ZUMY)) je mentionnais la possibilité d’évoquer le nombre de bits d’information produits par l’Homme depuis le 01.01.1946, c’est chose faite dans le texte qui suit.

D’abord pourquoi le 01.01.1946 ? Parce que cette date nous amène 80 ans en arrière, au sortir de la seconde guerre mondiale (qui a fait plus de 50 millions de morts sur une population globale d’environ 2,3 milliards d’humains), époque où à la mort à l’échelle industrielle succède l’industrialisation du calcul.
En effet avec les travaux d’Alan Turing, John Von Neuman et Norbert Wiener, et le dévoilement public de l’ENIAC en février 1946 (premier ordinateur Turing-complet entièrement électronique) le calcul machinique n’est plus seulement une assistance optionnelle, il prend le chemin de l’autonomisation, il s’approche du coeur de la civilisation. L’effort dévolu à la distribution de la mort se transforme en effort dévolu au calcul sans que l’on se pose vraiment de question sur le projet civilisationnel...<br>

Pourquoi “le nombre de bits” ? Parce que le bit, valant 1 ou 0, est l’unité d’information élémentaire et indivisible, qui sous-tend tout stockage et tout calcul machinique, c’est en quelque sorte l’atome de nos vies numériques obligatoires.
Le nombre de bits d’information produit par l’Homme avant 1946 est essentiellement nul, mais depuis il a augmenté et même exponentiellement, il est aujourd’hui de l’ordre de ${10}^{24}$ à ${10}^{25}$ soit entre 1 et 10 millions de milliards de milliards de bits. Voici quelques nombres qui donneront une idée de ce que cela représente (sur la base de ${10}^{24}$ bits):<br>
* ${10}^{24}$ bits $\approx$ 100000 milliards de Go, donc il faudrait 100 milliards de disques de 1To (1To = 1000Go) pour stocker une telle quantité de données
* ${10}^{24}$ bits signifie autant de bits qu’il y a de millilitres d’eau sur la Terre.
* ${10}^{24}$ ~ plusieurs millions de fois plus que le nombre de grains de sable sur Terre.

Je mentionnais le fait que l’augmentation de ce nombre est exponentielle, en effet il double tous les deux à trois ans (plus de 90 à 95% des données ont été produites après 2010), et comme toute augmentation exponentielle dans le monde physique, les ressources étant finies, il finira inévitablement par se produire un coup d’arrêt à cette croissance, c’est la décroissance forcée. On ne peut pas dévoluer toutes les terres rares, toute l’énérgie éléctrique, au calcul et au stockage de données soit-disant immatérielles, oui, je voulais souligner qu’on nous parle sans arrêt de procédures dématerialisées (carte grise, pièce d’identité, etc) mais lorsqu’on observe l’envers du décor, on voit bien qu’il faut beaucoup de ressources et de matériel pour dématerialiser...<br>

Je reviens à mes ${10}^{24}$, supposons qu’on ait à décomposer en facteurs premiers un nombre à 49 chiffres comme
<p align="center">N = 1008602631783078982698112027600844080000000000027</p>

(qui est de l’ordre de ${10}^{48}$), l’algorithme naïf consiste à diviser consécutivement par tous les entiers inférieurs à la racine carrée de N, soit un nombre de l’ordre de ${10}^{24}$.<br>
Essayons de voir ce que cela représente, supposons que notre machine à calculer soit capable de faire 1 milliard de divisions par seconde, et bien le calcul prendrait environ 300 millions d’années. C’est beaucoup trop pour de simples mortels, un “brute forceur” i.e. un individu adepte du calcul par la force brute dirait : “et si on mettait toutes les machines du monde sur la tache”, d’accord, si on suppose qu’il y en a 5 milliards, on passe de 300 millions d’années à 21 jours, gain énorme !
Mais est-ce vraiment un gain ? Est-ce raisonnable de mobiliser toutes les machines à calculer du monde pendant 21 jours pour un tel calcul ? Il va de soit que non.<br>
C’est ici qu’on réalise que la puissance de calcul, seule, n’est rien. Si on utilise le mauvais algorithme, alors quelque soit la puissance de calcul que nous avons entre les mains nous ne faisons que dilapider les ressources disponibles. Dans nombre de cas c’est l’esprit humain qui doit s’atteler à la tache pour produire des algorithmes
beaucoup plus efficace que l’algorihtme naïf (dans le cas présent si tu veux les noms c’est SIQS, MPQS, ECM et GNFS et c’est une quête qui dure au moins depuis Gauss).

Au terme de cet épisode nous réalisons que
* être obsédé par les ordres de grandeurs c’est bien (pour savoir de quoi on parle)
* trouver le bon algorithme est parfois indispensable
* écrire du code efficace (moins de calculs, moins de données sotckées, etc...) ne devrait pas être une quête optionnelle ajoutée en bout de course,
cela devrait être à la base de tout travail sérieux. Car cela confère à notre production des qualités désirables (rapidité, économie des ressources) et nécessaires si on veut éloigner la décroissance forcée.

La suite au prochain épisode.

