#!/bin/bash

MAILFROM="{{ mail_from }}"
MAILADDR="{{ GALAXY_ADMIN_EMAIL }}"

if [[ $1 == "html" ]]; then
  SUBJECT=$(echo -e "{{ success_mail_subject }}\nContent-Type: text/html")
else
  SUBJECT="{{ success_mail_subject }}"
fi

#________________________________
# Get Distribution
if [[ -r /etc/os-release ]]; then
    . /etc/os-release
fi

#________________________________
# Check if mail is installed
function check_mail {
  type -P mail &> /dev/null || install_mail;
}

#________________________________
# Install mail
function install_mail {

  # sudo is required to install mail.
  if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
  fi

  # install mail
  if [[ $ID = "ubuntu" ]]; then
    DEBIAN_FRONTEND=noninteractive apt-get install -yq mailutils
  elif [[ $ID = "centos" ]]; then
    yum install -y mailx
  else
    echo "Not supported distribution"
    exit 1
  fi

}

#________________________________
function mailcmd {

  if [[ $ID == "ubuntu" ]]; then
    mail -r $MAILFROM -s "$SUBJECT" $MAILADDR
  elif [[ $ID == 'centos' ]]; then
    mail -aFrom:$MAILFROM -s "$SUBJECT" $MAILADDR }
  fi

}

#________________________________
#________________________________

check_mail

if [[ $1 == "plain" ]]; then

  echo "$2" | mailcmd

elif [[ $1 == "html" ]]; then

 mailcmd < $2

fi
