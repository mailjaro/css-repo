#!/usr/bin/fish
pushd ~/Documents/doc/css-doc

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
sd '📝 ' '' css-2.adoc
sd '🌐 ' '' css-2.adoc
sd '👉 ' '' css-2.adoc
sd '🎨 ' '' css-2.adoc
sd '⚙️ ' '' css-2.adoc
sd '📦 ' '' css-2.adoc
sd '📐 ' '' css-2.adoc
sd '📏 ' '' css-2.adoc
sd '🖼️ ' '' css-2.adoc
sd '🏷️ ' '' css-2.adoc
sd '🌳 ' '' css-2.adoc
sd '✅ ' '' css-2.adoc
sd '✔' 'Y' css-2.adoc
sd '❌ ' ' - ' css-2.adoc
sd '🔗 ' '' css-2.adoc
sd '🔸 ' '' css-2.adoc
sd '2️⃣ ' '2. ' css-2.adoc
sd '3️⃣ ' '3. ' css-2.adoc
sd '4️⃣ ' '4. ' css-2.adoc
sd '5️⃣ ' '5. ' css-2.adoc
sd '6️⃣ ' '6. ' css-2.adoc
sd '7️⃣ ' '7. ' css-2.adoc

asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri \
            config/masterHTML-2.adoc -o builds/css-2.html

cp css-2.adoc css-3.adoc

asciidoctor-pdf config/masterPDF.adoc --theme=styles/asciidoctor-default.yml \
                -o builds/css.pdf

popd