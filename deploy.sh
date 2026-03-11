cat > ~/deploy.sh << 'SCRIPT'
#!/bin/bash
TOMCAT_HOME="/opt/tomcat"
TOMCAT_SERVICE="tomcat"
WEBAPPS="$TOMCAT_HOME/webapps"
LOGS="$TOMCAT_HOME/logs/catalina.out"
WAR_SOURCE="/vagrant"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

afficher_statut() {
    STATUS=$(systemctl is-active $TOMCAT_SERVICE 2>/dev/null)
    if [ "$STATUS" = "active" ]; then
        echo -e "  Etat : ${GREEN}EN MARCHE${NC}"
    else
        echo -e "  Etat : ${RED}ARRETE${NC}"
    fi
}

while true; do
    clear
    echo -e "${CYAN}"
    echo "  ╔══════════════════════════════════════════╗"
    echo "  ║      GESTION TOMCAT 9 - srv-web          ║"
    echo "  ╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    afficher_statut
    echo ""
    echo "  [1]  Demarrer Tomcat"
    echo "  [2]  Arreter Tomcat"
    echo "  [3]  Redemarrer Tomcat"
    echo "  [4]  Lister les applications deployees"
    echo "  [5]  Voir les logs Tomcat"
    echo "  [6]  Statut detaille"
    echo "  [0]  Quitter"
    echo ""
    read -p "  Votre choix : " choix
    case $choix in
        1) sudo systemctl start $TOMCAT_SERVICE && echo -e "${GREEN}Tomcat demarre${NC}" ;;
        2) sudo systemctl stop $TOMCAT_SERVICE && echo -e "${RED}Tomcat arrete${NC}" ;;
        3) sudo systemctl restart $TOMCAT_SERVICE && echo -e "${YELLOW}Tomcat redemarre${NC}" ;;
        4) ls -lh "$WEBAPPS" ;;
        5) tail -50 "$LOGS" ;;
        6) sudo systemctl status $TOMCAT_SERVICE ;;
        0) echo -e "${GREEN}Au revoir !${NC}" ; exit 0 ;;
        *) echo -e "${RED}Option invalide${NC}" ;;
    esac
    read -p "Appuyez sur Entree pour continuer..." dummy
done
SCRIPT

chmod +x ~/deploy.sh
./deploy.sh