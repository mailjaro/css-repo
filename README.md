# 📘 Litt om CSS

> Et kort, lite og praktisk hefte om CSS på Linux.  
> Skrevet av Jan R Sandbakken.

---

## ❗ Viktig info

✅ Husk: Start enhver editering med

- `git fetch origin`
- `git pull`

✅ Husk: Avslutt enhver editering med

- Lagre alle ulagrede filer
- `./runner.sh` (anbefalt)
- `git add -A`
- `git commit -m "Beskrivelse"`
- `git push`

(eller det ekvivalente fra **VS Code**.)

---

## 📌 Om prosjektet

- ⚙️ J
- 🧩 U

## 🗂️ Struktur

Her ser vi den fulle strukturen når alt er konvertert og produsert (hvilket kan oppnås ved å kjøre skriptet `runner.sh`):

```text
.
├── builds
│   ├── css-1.html
│   ├── css-2.html
│   ├── css-dark.epub
│   ├── css-light.epub
│   └── css.pdf
├── config
│   ├── common.yaml
│   ├── masterHTML-1.adoc
│   ├── masterHTML-2.adoc
│   └── masterPDF.adoc
├── css-1.adoc
├── css-2.adoc
├── css-3.adoc
├── css.md
├── examples
│   ├── test-arv.css
│   ├── test-arv.html
│   ├── test-display.css
│   └── test-display.html
├── images
│   └── css-cover.png
├── README.md
├── runner.sh
└── styles
    ├── asciidoctor-default.css
    ├── asciidoctor-default.yml
    ├── epub-dark.css
    └── epub-light.css
```

(Flere HTML/CSS-eksempler kan bli lagt til ved behov.)

## 📌 Eksport til EPUB

EPUB kan med hell produseres direkte fra MD med `pandoc`. En CSS for mørk og lys stil er laget, samt en **common.yaml** for metadata.

Her er `pandoc`-kommandoene for hver av stilene:

```bash
pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-dark.css -o \
   builds/css-dark.epub
```

```bash
pandoc css.md  \
   --metadata-file=config/common.yaml \
   --css=styles/epub-light.css -o \
   builds/css-light.epub
```

Her er metadataene i **common.yaml**:

```text
title: "Litt om CSS"
author: "Jan Roger Sandbakken"
version: "1.0"
date: "2026-02-19"
language: "nb"
rights: © 2026 Jan Roger Sandbakken
```

## 📌 Konvertering til ADOC

Følgende kommando konverterer **css.md** til **css-1.adoc** (første av tre ADOC-versjoner). Denne inneholder bl.a. MD-ikoner:

```bash
pandoc css.md --metadata-file=./config/common.yaml \
                 --wrap=none -f markdown-smart \
                 -o css-1.adoc
```

## 📌 Uredigert eksport til HTML

For produksjon av formater ved `asciidoctor` er det laget masterfiler med *preambles* og nødvendig *includes*. Her er **masterHTML-1.adoc**:

```text
= Litt om CSS
Jan R Sandbakken <mailjaro@gmail.com>
v1.0 2026-02-19
:description: Dette heftet tar for seg grunnleggende CSS
:doctype: book
:icons: font
:toc: left
:toc-title: Innholdsfortegnelse
:toclevels: 4
:sectanchors:
:source-highlighter: rouge
:rouge-style: github
image::../images/css-cover.png[role=cover,align=center]

include::../css-1.adoc[]
```
I tillegg er default CSS for `asciidoctor` hentet inn og inkluderes i følgende produksjonskommando:

```bash
asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri -a linkcss=false \
            config/masterHTML-1.adoc \
            -o builds/css-1.html
```

Opsjonene

```bash
-a linkcss=false
-a data-uri
```
sørger for at en produsert CCS og bilde (forsidebilde) inkluderes direkte i HTML-filen (så den enkelt kan flyttes rundt).

❗ **asciidoctor**-kommandoen kjøres av **runner.sh**, men tanken er at **css-1.adoc** også kan editeres/finpusses for ADOC-spesifikk formatering før man produserer HTML-format med denne kommandoen manuelt. Det anbefales selvsagt alltid å gjøre tekstlige editeringer, retting av trykkfeil etc, på hovedfilen **css.md** i forkant.

## 📌 Redigering av ADOC

Man starter med å kopiere `css-1.adoc` til `css-2.adoc` (alle endringer gjøres så på sistnevnte):

```bash
cp css-1.adoc css-2.adoc
```

Deretter sørger man for at `source`-objekter ikke blir linjedelt (viktig for PDF):

```bash
sd '\[source,text\]' '[%unbreakable]\n[source,text]' css-2.adoc
sd '\[source,json\]' '[%unbreakable]\n[source,json]' css-2.adoc
```

Så fjernes ikoner (håndteres ikke av PDF). For dette konkrete heftet er det nødvendig og tilstrekkelig å gjøre:

```bash
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
```

❗ **asciidoctor**-kommandoen kjøres av **runner.sh**, men tanken er at **css-2.adoc** også kan editeres/finpusses for ADOC-spesifikk formatering før man produserer HTML-format med denne kommandoen manuelt. Det anbefales selvsagt alltid å gjøre tekstlige editeringer, retting av trykkfeil etc, på hovedfilen **css.md** i forkant.

## 📌 Redigert eksport til HTML

Følgende kommando produserer HTML fra den nyredigerte `css-2.adoc` (inkludert i HTML-masterfil 2):

```bash
asciidoctor -a stylesheet=../styles/asciidoctor-default.css \
            -a data-uri -a linkcss=false \ 
            config/masterHTML-2.adoc -o builds/css-2.html
```

## 📌 Redigert eksport til PDF

Tanken er nå at man har behov for å redigerer ytterligere for PDF, kanskje legge inn nødvendig legge sideskift (`<<<`) enkelte steder o.l. Det forutsettes her at man derfor først kopiere  `css-2.adoc` til `css-3.adoc` og redigerer denne videre.

Masterfilen for PDF ser nemlig slik ut:

```text
= Litt om CSS
Jan R Sandbakken <mailjaro@gmail.com>
v1.0 2026-02-12
:description: Dette heftet tar for seg grunnleggende CSS
:doctype: book
:front-cover-image: image:../images/css-cover.png[]
:title-page:
:icons: font
:toc: left
:toc-title: Innholdsfortegnelse
:toclevels: 4
:sectanchors:
:source-highlighter: rouge
:rouge-style: base16.dark

include::../css-3.adoc[]
```

Følgende kommando produserer da PDF-versjon av boken:

```bash
asciidoctor-pdf config/masterPDF.adoc \
                --theme=styles/asciidoctor-default.yml \
                -o builds/css.pdf
```

❗ **asciidoctor-pdf**-kommandoen kjøres av **runner.sh**, men tanken er at **css-3.adoc** også kan editeres/finpusses før man produserer PDF-format med denne kommandoen manuelt. Det anbefales selvsagt alltid å gjøre tekstlige editeringer, retting av trykkfeil etc, på hovedfilen **css.md** i forkant.

## 🐚 Kommandoer samlet i et shell

Her er alt av kommandoer samlet i et fish-shell `runner.sh`:

```bash
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
```

## 📌 Makefile

Det er laget en midlertidig Makefile som hjelper både med produksjon og lesing, foreløpig bare

```bash
make epub
```

som produserer (den mørke) EPUB-filen, mens kommandoen

```bash
make open-epub
```

åpner denne for lesing.

Dette vil bli utvidet senere.

## 📚 Andre bøker og hefter i serien

📘 Linux: Det neste steget

📘 Litt om Git

📘 Litt om VS Code

📘 Litt om GPG
