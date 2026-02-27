#!/usr/bin/fish
pushd ~/Documents/doc/css-doc
mkdir -p builds

pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-dark.css -o \
   builds/css-dark.epub

pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-light.css -o \
   builds/css-light.epub

pandoc css.md --metadata-file=./config/common.yaml \
                 --wrap=none -f markdown-smart -o css-1.adoc

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-1.adoc -o builds/css-1.html

cp css-1.adoc css-2.adoc
sd '\[source,text\]' '[%unbreakable]\n[source,text]' css-2.adoc
sd '\[source,css\]' '[%unbreakable]\n[source,css]' css-2.adoc
sd '\[source,html\]' '[%unbreakable]\n[source,html]' css-2.adoc
sd '\p{Extended_Pictographic}\uFE0F? ' '' css-2.adoc  # Fjerner emojis

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-2.adoc -o builds/css-2.html

cp css-2.adoc css-3.adoc

asciidoctor-pdf config/masterPDF.adoc --theme=styles/asciidoctor-default.yml \
                -o builds/css.pdf

popd