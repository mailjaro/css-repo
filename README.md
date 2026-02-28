# 📝 "Litt om CSS" — struktur og mål

Prosjektet gir et kort og praktisk hefte om grunnleggende CSS.

## 🎯 Mål

- Gjøre CSS mer tilgjengelig for folk som har behov for HTML- eller EPUB-formatering mer sporadisk.
- På strømlinjet vis produsere ferdige, lesevennlige EPUB-, HTML- og PDF-utgaver av heftet.  

## Prosjektstruktur

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
├── Makefile
├── README.md
├── runner.sh
└── styles
    ├── asciidoctor-default.css
    ├── asciidoctor-default.yml
    ├── epub-dark.css
    └── epub-light.css
```

## ⚙️ Produksjon

De ulike formatene kan bygges ved **make** eller ved kjøring av skriptet **./runner.sh**.

Make-kommandoer:

```bash
make epub     # genererer EPUB
make html1    # generer HTML med emojis
make html2    # generer HTML uten emojis
make pdf      # generer PDF
make clean    # fjerner genererte filer
```

## 🔁 Arbeidsflyt

1. Produserer lys og mørk EPUB fra **css.md** via **pandoc**  
2. Konverterer **css.md** til **css-1.adoc** ved pandoc   
3. Produserer renset **css-2.adoc** fra **css-1.adoc** ved ulike **sd**-transformasjoner
4. Juster og PDF-tilpasser **css-3.adoc** fra **css-2.adoc** ved ulike **sd**-transformasjoner
5. Bygger HTML 1 og 2 med **asciidoctor**
6. Bygger PDF med **asciidoctor-pdf**

## 📁 Nøkkelfiler
- Kilde: css.md  
- Metadata:
  - config/common.yml for EPUBs
  - config/masterHTML-1.adoc for HTML1
  - config/masterHTML-2.adoc for HTML2
  - config/masterPDF.adoc for PDF
- Stiler:
  - styles/epub-light.css for EPUBLYS
  - styles/epub-dark.css for EPUBMØRK
  - styles/asciidoctor-default.css for HTMLs
  - styles/asciidoctor-default.yml for PDF
- Verktøy: **pandoc**, **asciidoctor**, **asciidoctor-pdf**  og **sd**  
- Testeksempler: examples/
- Output: builds/  

## 💡 Tips

ADOC-filer kan gjerne fintilpasses manuelt før produksjon for best mulig utnyttelse av Asciidoc eller andre formatspesifikke endringer.

## 👤 Forfatter & lisens
Metadata (tittel, forfatter, dato) finnes i config/common.yaml. Se repo for lisensinformasjon.