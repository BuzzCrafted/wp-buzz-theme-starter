#!/bin/bash

set -e

if [ $1 == '--help' ]; then
  echo "Theme Starter script v1.1.0"
  echo "usage: bash bin/setup.sh --theme 'Mytheme'"
  echo "usage via npm-scripts: npm run setup -- --theme 'Mytheme'"
  exit 0
fi

if [ $# -ne 2 ]; then
  echo 'Error: Required Two arguments'
  exit 1
fi

if [ $1 != '--theme' ]; then
  echo "Error: Wrong option name"
  exit 1
fi

THEME=$2

#THEME_LOWER=${THEME,,}
THEME_LOWER=$( tr 'A-Z' 'a-z' <<<"$THEME" )
THEME_ARRAY=($THEME)
THEME_PASCAL_SNAKE=`echo ${THEME_ARRAY[@]^} | gsed -r 's/ /_/g'`
THEME_KEBAB=`echo ${THEME_LOWER} | gsed -r 's/ /-/g'`
THEME_SNAKE=`echo ${THEME_LOWER} | gsed -r 's/ /_/g'`
THEME_CAPITAL_CAMEL_SNAKE=`echo ${THEME_PASCAL_SNAKE} |  gsed -r 's/_//g'`

#Defaults
THEME_URI_DEF="https:\/\/github.com\/dmitri-ko\/wp-theme-boilerplate.git"
THEME_AUTHOR_DEF="Dmitry Kokorin"
THEME_AUTHOR_URI_DEF="https:\/\/github.com\/dmitri-ko"
THEME_TAGS_DEF="custom-theme, theme-boilerplate"

#if [ ! -d ../${THEME_KEBAB} ]; then
#  echo "Error: Cannot execute"
#  echo "The directory name and the Theme Slug should be the same character string"
#  echo "Directory name: $(cd $(dirname $0)/..;pwd)"
#  echo "Theme Slug: ${THEME_KEBAB}"
#  exit 1
#fi

echo "Info: Run Theme Starter script"

echo "Info: Rename folder to ${THEME_KEBAB}"
cd ..
mv wp-buzz-theme-starter ${THEME_KEBAB}
cd ${THEME_KEBAB}

if [ -d ./.git ]; then
  rm -rf ./.git
  echo "Info: Delete .git"
fi

if [ -f ./languages/wp-buzz-theme-starter.pot ]; then
  mv ./languages/wp-buzz-theme-starter.pot ./languages/${THEME_KEBAB}.pot
  echo "Info: Rename to ${THEME_KEBAB}.pot"
fi

read -p "Theme template ['']: " theme_template
THEME_TEMPLATE=${theme_template:-''}

if [ $THEME_TEMPLATE != '' ]; then
  THEME_DESCRIPTION_DEF="Customized child theme for WordPress."
else 
  THEME_DESCRIPTION_DEF="Customized theme for WordPress."
fi

read -p "Theme URI [$THEME_URI_DEF]: " theme_uri
THEME_URI=${theme_uri:-$THEME_URI_DEF}

read -p "Theme Author [$THEME_AUTHOR_DEF]: " author
THEME_AUTHOR=${author:-$THEME_AUTHOR_DEF}

read -p "Theme Author [$THEME_AUTHOR_URI_DEF]: " author_uri
THEME_AUTHOR_URI=${author_uri:-$THEME_AUTHOR_URI_DEF}

read -p "Theme Desciption [$THEME_DESCRIPTION_DEF]: " theme_description
THEME_DESCRIPTION=${theme_description:-$THEME_DESCRIPTION_DEF}

read -p "Theme tags [$THEME_TAGS_DEF]: " theme_tags
THEME_TAGS=${theme_tags:-$THEME_TAGS_DEF}

find $PWD -name '*.php' -o -name 'style.css'  -o -name '*.pot' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-name}/${THEME}/g"
find $PWD -name '*.php' -o -name 'composer.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-namespace}/${THEME_CAPITAL_CAMEL_SNAKE}/g"
find $PWD -name '*.php' -o -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-slug}/${THEME_KEBAB}/g"
find $PWD -name '*.php' -o -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/WP_Buzz/${THEME_CAPITAL_CAMEL_SNAKE}/g"

find $PWD  -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-uri}/${THEME_URI}/g"
find $PWD  -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-author}/${THEME_AUTHOR}/g"
find $PWD  -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-author-uri}/${THEME_AUTHOR_URI}/g"
find $PWD  -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-description}/${THEME_DESCRIPTION}/g"
find $PWD  -name 'style.css'  -o -name '*.pot' -o -name 'package.json' -o -name 'theme-settings.json' -o -name 'readme.txt' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-tags}/${THEME_TAGS}/g"

if [ -f ./inc/class-wp-theme-boilerplate.php ]; then
  echo "Info: Renaming main theme base files  for theme: ${THEME}"
  mv ./inc/class-wp-buzz-theme-factory.php ./inc/class-${THEME_KEBAB}-theme-factory.php
  mv ./inc/builder/class-wp-buzz-theme-builder.php ./inc/builder/class-${THEME_KEBAB}-theme-builder.php
  mv ./inc/configurator/class-wp-buzz-theme-content-configurator.php ./inc/configurator/class-${THEME_KEBAB}-theme-content-configurator.php
fi

read -p "Install dependancies [yes]: " answer
IS_INSTALL_DEPENDENCIES=${answer:-yes}

if [ ${answer:-yes} == 'yes' ]; then
  echo "Info: Theme ${THEME} initialization"
  npm install
  mkdir vendor-prefixed
  composer install
fi

if [ $THEME_TEMPLATE != '' ]; then
  find $PWD  -name 'style.css' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-template}/Template: ${THEME_TEMPLATE}/g"
else 
  echo "Info: Copying optional files"
  find $PWD  -name 'style.css' -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/{theme-template}//g"
  cp -R ./optional/ .
fi
rm -rf ./optional/

echo "Info: Copying post-install files"
mkdir -p .git/hooks/
cp -r post-install/hooks/ .git/hooks/
chmod 0777 .git/hooks/pre-commit
chmod 0777 .git/hooks/pre-push

mkdir -p .github/
cp -r post-install/.github/ .github/

cp -r post-install/.travis.yml .

echo "Info: Generated a WordPress theme: ${THEME}"

echo "Info: Please manually delete the /bin/setup.sh after Theme Starter script execution."