# IntruderWatchMan
<p align="justify">Pour le projet 3A, nous nous sommes rendus compte que nous avions des compétences complémentaires dans le domaine de l’informatique et nous avons donc choisi de les mettre en lien dans un projet personnel alliant notre passion pour le pentesting et notre projet d’avenir. En effet, notre groupe étant composé exclusivement de personnes souhaitant faire SQR dans la suite du cursus, nous voulons réaliser un projet dans lequel nous allons réellement nous investir et ce pour mettre en valeur notre CV pour de futurs entretiens. Notre projet s’intitule "IntruderWatchMan" et consiste à réaliser des pentests<sup>(1)</sup> de manière automatique. Pour cela nous allons utiliser le site TryHackMe. Ce site met à disposition des machines distantes de différents niveaux et demandant de multiples compétences. Pour valider une machine, il faut trouver tous les flags<sup>(2)</sup>. Nous allons réaliser en groupe le pentest de différentes machines listées dans la suite du sujet pour ensuite implémenter les procédés dans un script afin d’automatiser l’intrusion. Nous avons pour objectif de faire entre 7 et 10 machines pour mettre au point notre script afin de tester son efficacité sur des machines n’ayant jamais été traitées. Chacun des pentests réalisés fera l’objet d’un rapport détaillant les méthodes et outils utilisés.</p>

Liste des machines :
* [LazyAdmin](https://tryhackme.com/room/lazyadmin)
* [BasicPentesting](https://tryhackme.com/room/basicpentestingjt)
* [HAJokerCTF](https://tryhackme.com/room/jokerctf)
* [Wonderland](https://tryhackme.com/room/wonderland)
* [AgentSudo](https://tryhackme.com/room/agentsudoctf)
* [BrooklynNineNine](https://tryhackme.com/room/brooklynninenine)
* [Overpass3](https://tryhackme.com/room/overpass3hosting)

Liste des outils et techniques :
* [Nmap](https://nmap.org) : Détecte les ports ouverts, identifie les services hébergés et obtient des informations
sur le système d’exploitation d’un ordinateur distant.
* [Gobuster](https://www.kali.org/tools/gobuster/) : Bruteforce des répertoires et des fichiers d’un site web.
* [Dirbuster](https://www.kali.org/tools/dirbuster/) : Bruteforce des répertoires et des fichiers d’un site web (en interface graphique).
* [Hydra](https://www.kali.org/tools/hydra/) : Brutforce différents protocoles comme le ssh etc...
* [Hashcat](https://hashcat.net/hashcat/) : Déchiffre les mots de passe à partir de hash.
* [Nikto](https://www.kali.org/tools/nikto/}) : Scan la sécurité d’un serveur web.
* [Stegseek](https://github.com/RickdeJager/stegseek) : Extrait des données cachées dans un fichier (un zip dans un jpeg etc...).
* [Steghide](https://steghide.sourceforge.net) : Complémentaire à Stegseek.
* [linpeas](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS) : Énumère les différentes failles potentielles pour des tentatives d’escalade de privi-
lèges.
* [john](https://www.kali.org/tools/john/) : Crack tout type de mots de passe.
* [ssh2john](https://github.com/openwall/john/blob/bleeding-jumbo/run/ssh2john.py) : Convertit une clef ssh en un fichier crackable par john.
* [zip2john](https://linuxconfig.org/how-to-crack-zip-password-on-kali-linux) : Permet de dézipper un zip demandant un mot de passe.
* [reverse_shell](https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet) : Permet à un utilisateur distant d’exécuter des commandes sur le système local
comme s’il était physiquement présent devant lui.
* [Metasploit](https://www.metasploit.com) : Outil regroupant différents exploits à lancer sur les machines cibles.
* [Msfvenom](https://docs.metasploit.com/docs/using-metasploit/basics/how-to-use-msfvenom.html) : Créer sur mesure des payloads.
* [lxc/lxd container](https://linuxcontainers.org) : Outil faciliant le management de containers.

_(1) : Un pentest est un test d’intrusion visant à déterminer la fiabilité de réseaux et de machines
face à des attaques informatiques._

_(2) : Un flag est une suite de caractères prouvant l’intrusion à différents niveaux de sécurité.
Exemple de flag : b53a02f55b57d4439e3341834d70c062_
