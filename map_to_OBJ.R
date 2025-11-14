# relief_3d_complet.R - Visualisation + Export STL (VERSION CORRIGÉE)
library(rayshader)
library(raster)

cat("🗺️  RELIEF 3D - VISUALISATION ET EXPORT\n")
cat("========================================\n\n")

# CHARGEMENT
cat("📂 Chargement de carte.tif...\n")
dem <- raster("data/carte.tif")
elmat <- as.matrix(dem)
elmat <- unname(elmat)
elmat[is.na(elmat)] <- min(elmat, na.rm=TRUE)
elmat <- elmat[nrow(elmat):1, ]

cat("✅ Données chargées : ", dim(elmat), "\n\n")

# VISUALISATION 3D
cat("🎨 Création de la vue 3D...\n")
shade <- sphere_shade(elmat, texture = "desert")
plot_3d(shade, elmat, 
        zscale = 10, 
        windowsize = c(800, 600), 
        theta = 45, phi = 45, 
        zoom = 0.7,
        background = "white")

cat("✅ Vue 3D affichée\n\n")

# EXPORT OBJ (MÉTHODE ALTERNATIVE QUI FONCTIONNE)
cat("💾 Export OBJ en cours...\n")
dir.create("output", showWarnings = FALSE)

# Utilisation de la scène 3D actuelle pour l'export
render_snapshot("output/temp_snapshot.png")  # Sauvegarde temporaire

# Export OBJ depuis la scène 3D
save_obj(
  filename = "output/carte_3D.obj",
  save_texture = FALSE
)


cat("\n✅ EXPORT TERMINÉ !\n")
cat("📦 Fichier : output/carte_3D.obj\n")
cat("🖨️  Format compatible impression 3D\n")
cat("\nℹ️  Le format OBJ fonctionne avec tous les slicers\n")
cat("   (Cura, PrusaSlicer acceptent .obj )\n")
