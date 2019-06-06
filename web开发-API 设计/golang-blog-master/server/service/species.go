package service

import (
	"log"
	"net/http"
	"strconv"
	"github.com/gorilla/mux"
	"github.com/unrolled/render"
	"SYSUServiceComputing/server/database/database"
)

func speciesHandler(formatter *render.Render) http.HandlerFunc {
	return func(w http.ResponseWriter, req *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Header().Set("Access-Control-Allow-Origin", "*")
		req.ParseForm()
		page := 1
		w.Write([]byte("{\"result\" : \n["))
		if req.Form["page"] != nil {
			page, _ = strconv.Atoi(req.Form["page"][0])
		}
		count := 0
		for i := 1; ; i++ {
			item := database.GetValue([]byte("species"), []byte(strconv.Itoa(i)))
			if len(item) != 0 {
				count++
				if count > pagelen*(page-1) {
					w.Write([]byte(item))
					if count >= pagelen*page || count >= database.GetBucketCount([]byte("species")) {
						break
					}
					w.Write([]byte(", \n"))
				}
			}
		}
		w.Write([]byte("]\n}"))
	}
}

func getSpeciesById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	_, err := strconv.Atoi(vars["id"])
	if err != nil {
		log.Fatal(err)
	}

	w.WriteHeader(http.StatusOK)
	data := database.GetValue([]byte("species"), []byte(vars["id"]))
	w.Write([]byte(data))
}

func speciesPagesHandler(w http.ResponseWriter, req *http.Request) {
	data := database.GetBucketCount([]byte("species"))
	w.Write([]byte(strconv.Itoa(data)))
}
