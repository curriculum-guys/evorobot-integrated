LIB_DIR := src/lib

remove_files = \
	cd $(LIB_DIR); \
	for file in "${1}*.so" "${1}.cpp"; do \
		if [ -f $$file ]; then \
			rm $$file; \
		fi \
	done

remove_build_dir = \
	cd $(LIB_DIR); \
	if [ -f build ]; then \
		rm -r build; \
	fi

compile_resource = \
	cd $(LIB_DIR); \
	python setup${1}.py build_ext --inplace; \
	cp ${2}*.so ../bin

build_image:
	docker build -t evrun_integrated:latest .

update_requirements:
	pip freeze > requirements.txt

create_alias:
	bash scripts/alias.sh
	$(source ~/.bash_aliases)

update_lab:
	bash scripts/lab.sh

update_version:
	bash scripts/tag.sh

compile_erdiscrim:
	$(call remove_build_dir)
	$(call remove_files,"ErDiscrim")
	$(call compile_resource,"ErDiscrim","ErDiscrim")
	echo "Compiled Successfully";

compile_erdpole:
	$(call remove_build_dir)
	$(call remove_files,"ErDpole")
	$(call compile_resource,"ErDpole","ErDpole")
	echo "Compiled Successfully";

compile_evonet:
	$(call remove_build_dir)
	$(call remove_files,"net")
	$(call compile_resource,"evonet","net")
	echo "Compiled Successfully";

compile_erpredprey:
	$(call remove_build_dir)
	$(call remove_files,"ErPredprey")
	$(call compile_resource,"ErPredprey","ErPredprey")
	echo "Compiled Successfully";

compile_erstaybehind:
	$(call remove_build_dir)
	$(call remove_files,"ErStaybehind")
	$(call compile_resource,"ErStaybehind","ErStaybehind")
	echo "Compiled Successfully";

compile_all: compile_erdiscrim compile_erdpole compile_evonet compile_erpredprey compile_erstaybehind
