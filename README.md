# Preview-Thumbnails-Maker



## Requirements
- ffmpeg
- ImageMagick
- ghostscript

To install them on macOS, type:
```
brew install ghostscript imagemagick ffmpeg
```
## Usage

```
curl -O https://raw.githubusercontent.com/receyuki/Preview-Thumbnails-Maker/master/previewThumbnails.sh
chmod +x ./previewThumbnails.sh
./previewThumbnails.sh youVideoFile.mp4
```
## Automator Quick Action Instillation
```
cd ~/Downloads && curl -O https://github.com/receyuki/Preview-Thumbnails-Maker/raw/master/automatorQuickAction/MakePreviewThumbnails.zip && unzip ./MakePreviewThumbnails.zip && rm MakePreviewThumbnails.zip && open ./MakePreviewThumbnails.workflow
```