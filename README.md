# Preview-Thumbnails-Maker

![ToS-4k-1920](https://user-images.githubusercontent.com/28808141/116063097-e6740d00-a6c7-11eb-936c-392a7183b58a.jpg)

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
./previewThumbnails.sh yourVideoFile.mp4
```
## Automator Quick Action Instillation
```
cd ~/Downloads && curl -LO https://github.com/receyuki/Preview-Thumbnails-Maker/raw/master/automatorQuickAction/MakePreviewThumbnails.workflow.zip && unzip ./MakePreviewThumbnails.workflow.zip && rm MakePreviewThumbnails.workflow.zip && open ./MakePreviewThumbnails.workflow
```
