const fs = require('fs');
const path = require('path');

function convertText(inputPath, outputPath, volumeTitle) {
  let content = fs.readFileSync(inputPath, 'utf-8');
  content = content.replace(/[\uA713\uA715]/g, '');

  let typstContent = '#import "template.typ": *\n\n';
  typstContent += '#show: book.with(\n';
  typstContent += '  title: "Libro de Cánticos",\n';
  typstContent += `  subtitle: "${volumeTitle}",\n`;
  typstContent += '  author: "Publicaciones Sumedhārāma"\n';
  typstContent += ')\n\n';
  
  typstContent += '#align(center)[\n';
  typstContent += '  #v(3cm)\n';
  typstContent += '  #text(size: 22pt, weight: "bold")[Cánticos]\n';
  typstContent += '  #v(1cm)\n';
  typstContent += `  #text(size: 14pt, style: "italic")[${volumeTitle}]\n`;
  typstContent += '  #v(2cm)\n';
  typstContent += '  #text(size: 12pt, weight: "bold")[Publicaciones Sumedhārāma]\n';
  typstContent += '  #v(0.5cm)\n';
  typstContent += '  #text(size: 10pt)[www.sumedharama.pt]\n';
  typstContent += ']\n#pagebreak()\n\n';

  // Include the full text wrapped in a clean formatting
  // We can also include the extracted text sections
  typstContent += '= Contenido del Libro\n\n';
  
  const lines = content.split('\n');
  let skipTableOfContents = true;
  let bodyLines = [];

  for (let line of lines) {
    let trimmed = line.trim();
    // Skip initial table of contents until Parte 1 body
    if (trimmed.startsWith('Parte 1') && skipTableOfContents) {
      // Check if it's the second occurrence (body) or first
      skipTableOfContents = false;
    }
    if (skipTableOfContents) continue;

    if (trimmed.startsWith('Parte ')) {
      typstContent += `\n= ${trimmed}\n\n`;
    } else if (trimmed !== '') {
      typstContent += `${trimmed} \n`;
    } else {
      typstContent += '\n';
    }
  }

  fs.writeFileSync(outputPath, typstContent, 'utf-8');
  console.log('Converted ' + inputPath + ' to ' + outputPath);
}

const root = 'C:\\Users\\santa\\OneDrive\\Documents\\Varabho\\proyectos\\aljamiado';
convertText(path.join(root, 'vol1_text.txt'), path.join(root, 'vol1.typ'), 'Volumen I: Cánticos Matinales y Vespertinos y Reflexiones');
convertText(path.join(root, 'vol2_text.txt'), path.join(root, 'vol2.typ'), 'Volumen II: Discursos, Parittas y Cánticos Funerarios');
