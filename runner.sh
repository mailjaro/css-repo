#!/usr/bin/fish
pushd ~/Documents/doc/css-doc
mkdir -p builds

pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-dark.css \
   --metadata cover-image=images/cover.png \
   -o builds/css-pan-dark.epub

pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-light.css \
   --metadata cover-image=images/cover.png \
   -o builds/css-pan-light.epub

pandoc css.md --metadata-file=./config/common.yaml \
                 --wrap=none -f markdown-smart -o css-1.adoc

echo "✅ Pandoc EPUB LIGHT and DARK successfully built."

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-1.adoc -o builds/css-1.html

cp css-1.adoc css-2.adoc
sd '\[source,text\]' '[%unbreakable]\n[source,text]' css-2.adoc
sd '\[source,css\]' '[%unbreakable]\n[source,css]' css-2.adoc
sd '\[source,html\]' '[%unbreakable]\n[source,html]' css-2.adoc
sd '❗' 'NOTE:' css-2.adoc
sd '‼️' 'CAUTION:' css-2.adoc
sd '\p{Extended_Pictographic}\uFE0F? ' '' css-2.adoc  # Fjerner emojis
sd ' 1️⃣' '' css-2.adoc
sd ' 2️⃣' '' css-2.adoc
sd ' 3️⃣' '' css-2.adoc
sd ' 4️⃣' '' css-2.adoc
sd ' 5️⃣' '' css-2.adoc
sd ' 6️⃣' '' css-2.adoc
sd ' 7️⃣' '' css-2.adoc


asciidoctor-epub3 config/masterEPUB-light.adoc \
                  -o builds/css-asc-light.epub
asciidoctor-epub3 config/masterEPUB-dark.adoc \
                  -o builds/css-asc-dark.epub

echo "✅ Asciidoctor EPUB LIGHT and DARK successfully built."

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-2.adoc -o builds/css-2.html

echo "✅ HTML1 and HTML2 successfully built."

cp css-2.adoc css-3.adoc

asciidoctor-pdf config/masterPDF.adoc --theme=styles/asciidoctor-default.yml \
                -o builds/css.pdf

echo "✅ PDF successfully built."

popd