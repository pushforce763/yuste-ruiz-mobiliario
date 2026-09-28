# Web Yuste Ruíz Mobiliario

Sitio estático (HTML/CSS/JS en un solo `index.html`) para GitHub Pages.

## Gestión de fotos

Cada categoría de la colección tiene su carpeta en `fotos/`:

```
fotos/
├── dormitorio/
├── dormitorio-juvenil/
├── comedor/
├── mesas-sillas/
├── sofas/
├── recibidor/
├── vestidores/
├── estudio-despacho/
├── colchones/
└── bases-canapes/
```

**Para añadir fotos**: sube las imágenes (jpg, png, webp, avif) a la carpeta
de su categoría y haz push (o arrástralas desde la web de GitHub:
*Add file → Upload files* dentro de la carpeta).

La GitHub Action (`.github/workflows/fotos.yml`) regenera `fotos.json`
automáticamente en cada push que toque `fotos/`. La web lee ese manifest:

- **Primera foto** de cada carpeta (orden alfabético/natural) = portada de la
  tarjeta de categoría. Usa prefijos numéricos para controlar el orden:
  `01-cama-roble.webp`, `02-armario.webp`...
- Al hacer clic en una categoría con fotos se abre la **galería** (lightbox)
  con todas las fotos de esa carpeta.
- Carpetas vacías muestran un placeholder "Foto pendiente".

No hace falta tocar `index.html` ni `fotos.json` a mano.

## Optimización recomendada

Antes de subir, redimensiona a ~1600px máx. y convierte a WebP:

```bash
for f in *.jpg; do cwebp -q 80 -resize 1600 0 "$f" -o "${f%.jpg}.webp"; done
```

## Publicar en GitHub Pages

1. Repo público → sube todo el contenido de esta carpeta.
2. Settings → Pages → Source: **GitHub Actions** (no "Deploy from a branch").
   El despliegue lo hace `.github/workflows/deploy-pages.yml` en cada push
   a `main`.
3. (Opcional) Custom domain + HTTPS automático.

Nota: la primera vez, ve a la pestaña **Actions** y habilita los workflows
si GitHub lo pide. La Action de `fotos.yml` necesita
`Settings → Actions → General → Workflow permissions → Read and write
permissions`.
