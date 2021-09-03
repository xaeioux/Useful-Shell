#!/bin/bash
INTERPRETER=`echo $SHELL | cut -d/ -f3`

if [ "$INTERPRETER" == "zsh" ]; then
  SHELLCONF=".zshrc"
else
  SHELLCONF=".bashrc"
fi

cd ~;
{ echo '#!/bin/bash';
  echo 'read -p "Tamanho da senha:" tamanho;';
  echo 'randompass=$(head /dev/urandom | tr -dc A-HJ-Z0-9a-hj-kl-z | head -c$tamanho);';
  echo 'echo "";echo "Senha: $randompass";echo "";';} > .mkpass.sh

chmod +x .mkpass.sh
echo "alias mkpass='cd ~ && ./.mkpass.sh'" >> $SHELLCONF
