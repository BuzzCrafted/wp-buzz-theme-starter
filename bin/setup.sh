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
THEME_LOWER_NO_SPACE=`echo ${THEME_ARRAY[@]^} | gsed -r 's/ //g'`
THEME_KEBAB=`echo ${THEME_LOWER} | gsed -r 's/ /-/g'`
THEME_SNAKE=`echo ${THEME_LOWER} | gsed -r 's/ /_/g'`
THEME_CAPITAL_CAMEL_SNAKE=`echo ${THEME_PASCAL_SNAKE} |  gsed -r 's/_//g'`

#Defaults
THEME_URI_DEF="https:\/\/github.com\/dmitri-ko\/wp-theme-boilerplate.git"
THEME_AUTHOR_DEF="Dmitry Kokorin"
THEME_AUTHOR_URI_DEF="https:\/\/github.com\/dmitri-ko"
THEME_TAGS_DEF="custom-theme, theme-boilerplate"

echo "Info: Run Theme Starter script"

echo "Info: Rename folder to ${THEME_KEBAB}"
cd ..
mv wp-buzz-theme-starter ${THEME_KEBAB}
cd ${THEME_KEBAB}

if [ -d ./.git ]; then
  rm -rf ./.git
  echo "Info: Deleted .git"
fi

if [ -f ./languages/wp-buzz-theme-starter.pot ]; then
  mv ./languages/wp-buzz-theme-starter.pot ./languages/${THEME_KEBAB}.pot
  echo "Info: Renamed to ${THEME_KEBAB}.pot"
fi

read -p "Theme template ['']: " theme_template
THEME_TEMPLATE=${theme_template:-''}

THEME_DESCRIPTION_DEF="Customized ${THEME_TEMPLATE:+child }theme for WordPress."

read -p "Theme URI [$THEME_URI_DEF]: " theme_uri
THEME_URI=${theme_uri:-$THEME_URI_DEF}

read -p "Theme Author [$THEME_AUTHOR_DEF]: " author
THEME_AUTHOR=${author:-$THEME_AUTHOR_DEF}

read -p "Theme Author URI [$THEME_AUTHOR_URI_DEF]: " author_uri
THEME_AUTHOR_URI=${author_uri:-$THEME_AUTHOR_URI_DEF}

read -p "Theme Description [$THEME_DESCRIPTION_DEF]: " theme_description
THEME_DESCRIPTION=${theme_description:-$THEME_DESCRIPTION_DEF}

read -p "Theme tags [$THEME_TAGS_DEF]: " theme_tags
THEME_TAGS=${theme_tags:-$THEME_TAGS_DEF}

for pattern in '{theme-name}' '{theme-namespace}' '{theme-slug}' 'WP_Buzz' '{theme-uri}' '{theme-author}' '{theme-author-uri}' '{theme-description}' '{theme-tags}'; do
  replacement=""
  case $pattern in
    '{theme-name}') replacement=$THEME ;;
    '{theme-namespace}') replacement=$THEME_CAPITAL_CAMEL_SNAKE ;;
    '{theme-slug}') replacement=$THEME_KEBAB ;;
    'WP_Buzz') replacement=$THEME_CAPITAL_CAMEL_SNAKE ;;
    '{theme-uri}') replacement=$THEME_URI ;;
    '{theme-author}') replacement=$THEME_AUTHOR ;;
    '{theme-author-uri}') replacement=$THEME_AUTHOR_URI ;;
    '{theme-description}') replacement=$THEME_DESCRIPTION ;;
    '{theme-tags}') replacement=$THEME_TAGS ;;
  esac

  find $PWD -type f \( -name '*.php' -o -name 'style.css' -o -name '*.pot' -o -name 'theme-settings.json' -o -name 'readme.txt' -o -name 'composer.json' -o -name 'package.json' \) \
    -not -iwholename './.git/*' -not -iwholename './node_modules/*' -not -iwholename './vendor/*' | xargs gsed -i "s/$pattern/$replacement/g"
done

echo "Info: Renaming theme base files for theme: ${THEME}"
for file in ./inc/class-wp-buzz-theme-factory.php  \
              ./inc/class-wp-buzz-theme-factory.php \
              ./inc/builder/class-wp-buzz-theme-builder.php \
              ./inc/configurator/class-wp-buzz-theme-content-configurator.php; do
    if [ -f "$file" ]; then
      new_file=$(echo "$file" | gsed -r "s/wp-buzz/${THEME_LOWER_NO_SPACE}/g")
      mv "$file" "$new_file"
    fi
done


read -p "Install dependancies [yes]: " answer
IS_INSTALL_DEPENDENCIES=${answer:-yes}

if [ ${answer:-yes} == 'yes' ]; then
  echo "Info: Theme ${THEME} initialization"
  npm install
  mkdir -p vendor-prefixed
  composer install
fi

if [ "$THEME_TEMPLATE" != '' ]; then
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

rm -rf ./post-install/

echo "Info: Generated a WordPress theme: ${THEME}"

echo "Info: Please manually delete the /bin/setup.sh after Theme Starter script execution."