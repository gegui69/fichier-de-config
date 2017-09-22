#!/bin/bash

# Script pour ceux qui veulent faire la mise à niveau de Mint depuis une version inférieur à la 18.2 vers la 18.2 tout
#en conservant l'intégration et la saisie manuelle des identifiants.

########################################################################
#parametrage du script de demontage du netlogon pour lightdm 
########################################################################
  touch /etc/lightdm/logonscript.sh
  grep "if mount | grep -q \"/tmp/netlogon\" ; then umount /tmp/netlogon ;fi" /etc/lightdm/logonscript.sh  >/dev/null
  if [ $? == 0 ] ; then
    echo "Presession Ok"
  else
    echo "if mount | grep -q \"/tmp/netlogon\" ; then umount /tmp/netlogon ;fi" >> /etc/lightdm/logonscript.sh
  fi
  chmod +x /etc/lightdm/logonscript.sh

  touch /etc/lightdm/logoffscript.sh
  echo "sleep 2 \
  umount -f /tmp/netlogon \ 
  umount -f \$HOME
  " > /etc/lightdm/logoffscript.sh
  chmod +x /etc/lightdm/logoffscript.sh

  ########################################################################
  #parametrage du lightdm.conf
  #activation du pave numerique par greeter-setup-script=/usr/bin/numlockx on
  ########################################################################
  echo "[SeatDefaults]
      allow-guest=false
      greeter-show-manual-login=true
      greeter-hide-users=true
      session-setup-script=/etc/lightdm/logonscript.sh
      session-cleanup-script=/etc/lightdm/logoffscript.sh
      greeter-setup-script=/usr/bin/numlockx on" > /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf


