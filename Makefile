YEAR := $(shell date +'%Y')
YEAR_MONTH := $(shell date +'%Y%b')
CALC_DIR := calc_$(YEAR_MONTH)

.PHONY: all validate_dir_osm_sea download_file_water_polygons extract_file_water_polygons create_calc_directory download_osm_file compile_extract_water_src pre_process extract_water add_rivers add_canals add_streams merge_water_maps

all: validate_dir_osm_sea download_file_water_polygons extract_file_water_polygons create_calc_directory download_osm_file compile_extract_water_src pre_process extract_water add_rivers add_canals add_streams merge_water_maps

validate_dir_osm_sea:
    @echo "Validating or creating OSM_sea/download directory..."
    @mkdir -p OSM_sea/download

download_file_water_polygons:
    @echo "Checking if water-polygons-split-4326.zip exists..."
    @if [ ! -f OSM_sea/download/water-polygons-split-4326.zip ]; then \
        echo "Downloading water-polygons-split-4326.zip..."; \
        echo "From https://osmdata.openstreetmap.de/data/water-polygons.html"; \
        curl -o OSM_sea/download/water-polygons-split-4326.zip https://osmdata.openstreetmap.de/download/water-polygons-split-4326.zip; \
    else \
        echo "File already exists."; \
    fi

extract_file_water_polygons:
    @echo "Extracting water-polygons-split-4326.zip..."
    @unzip -o OSM_sea/download/water-polygons-split-4326.zip -d OSM_sea/download

create_calc_directory:
    @echo "Creating OSM water layer calc directory..."
    @mkdir -p $(CALC_DIR)
    @cp -r calc_2021Feb $(CALC_DIR)

download_osm_file:
    @echo "Downloading planet-latest.osm.pbf file..."
    @curl -o $(CALC_DIR)/extract_water/osm/planet-latest.osm.pbf https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf

compile_extract_water_src:
    @echo "Compiling extract_water source code..."
    @$(MAKE) -C $(CALC_DIR)/extract_water/src/

pre_process:
    @echo "Executing a01-preset.sh in extract_water directory..."
    @cd $(CALC_DIR)/extract_water && ./a01-preset.sh

extract_water:
    @echo "Executing a02-waterlayer.sh in extract_water directory..."
    @cd $(CALC_DIR)/extract_water && ./a02-waterlayer.sh

add_rivers:
    @echo "Compiling add_river source code..."
    @$(MAKE) -C $(CALC_DIR)/add_river/src/
    @echo "Executing auto.sh in add_river directory..."
    @cd $(CALC_DIR)/add_river && ./auto.sh

add_canals:
    @echo "Compiling add_canal source code..."
    @$(MAKE) -C $(CALC_DIR)/add_canal/src/
    @echo "Executing auto.sh in add_canal directory..."
    @cd $(CALC_DIR)/add_canal && ./auto.sh

add_streams:
    @echo "Compiling add_stream source code..."
    @$(MAKE) -C $(CALC_DIR)/add_stream/src/
    @echo "Executing auto.sh in add_stream directory..."
    @cd $(CALC_DIR)/add_stream && ./auto.sh

merge_water_maps:
    @echo "Compiling merge_water source code..."
    @$(MAKE) -C $(CALC_DIR)/merge_water/src/
    @echo "Executing auto.sh in merge_water directory..."
    @cd $(CALC_DIR)/merge_water && ./auto.sh

visualize_water_map:
    @echo "Compiling merge_water/figure source code..."
    @$(MAKE) -C $(CALC_DIR)/merge_water/Figure/src/
    @echo "Executing s04-jpg.sh in merge_water/Figure directory..."
    @cd $(CALC_DIR)/merge_water/Figure && ./s04-jpg.sh