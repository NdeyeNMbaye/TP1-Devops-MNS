# TP1-Devops-MNS
TD1 - Déploiement d'une Application Web avec Vagrant
Description
Ce projet consiste à déployer une application web Java sur un serveur Tomcat en utilisant Vagrant et VirtualBox. Il s'agit de créer une machine virtuelle, d'y installer JDK, Tomcat 9 et de déployer une application web Java. Un script deploy.sh est également fourni pour gérer le serveur Tomcat via un menu interactif.

Prérequis

### VirtualBox >= 6.1
Vagrant >= 2.3
Git

### Contenu du Vagrantfile
Le Vagrantfile définit 1 machine virtuelle :
srv-web (192.168.56.10)

Box : ubuntu/bionic64
RAM : 2048 MB, 2 CPUs
Installe JDK 8, JDK 11 et JDK 17
Installe Tomcat 9 comme service systemd
Déploie l'application sample.war sur Tomcat
Copie le script deploy.sh pour la gestion du serveur

 ### Démarrer la VM & Accéder à l'application
 
 -->vagrant up
 Application : http://localhost:8080/sample
 <img width="1822" height="564" alt="image" src="https://github.com/user-attachments/assets/33054fd4-3663-4834-8b23-f0de446fc73f" />

 #### Script deploy.sh
Le script deploy.sh permet de gérer le serveur Tomcat via un menu interactif :

<img width="947" height="499" alt="image" src="https://github.com/user-attachments/assets/95457829-e40d-43ce-9a14-1f964c0027e5" />

Le menu propose les options suivantes :

Démarrer Tomcat
Arrêter Tomcat
Redémarrer Tomcat
Vérifier le statut de Tomcat
Quitter

##### Démarrage de la VM

<img width="542" height="426" alt="image" src="https://github.com/user-attachments/assets/69aadebb-6410-49f7-b040-a84c9f044e95" />

<img width="918" height="821" alt="image" src="https://github.com/user-attachments/assets/28adcc5b-3423-4ebf-aae1-d8eb683ff14c" />

<img width="971" height="651" alt="image" src="https://github.com/user-attachments/assets/6159a321-1fce-450e-a91e-ff3621e27b4a" />

<img width="960" height="479" alt="image" src="https://github.com/user-attachments/assets/23f45610-b020-4943-90ae-be0d35808d43" />




