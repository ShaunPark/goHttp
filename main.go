package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/api/v1/users", getUserHandler)
	http.ListenAndServe(":5000", nil)
}

func handler(w http.ResponseWriter, req *http.Request) {
	test := req.URL.Query().Get("test")
	println(test)
	w.Write([]byte(fmt.Sprintf("Hello world : %s", test)))
}

func getUserHandler(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Content-Type", "application/json")
	ret := []user{}
	ret = append(ret, user{Id: "test1", Name: "name1"})
	ret = append(ret, user{Id: "test2", Name: "name2"})
	ret = append(ret, user{Id: "test3", Name: "name3"})
	bytes, _ := json.Marshal(response{Status: "success", Data: ret})
	w.Write(bytes)
}

type user struct {
	Id   string `json:"id"`
	Name string `json:"name"`
}

type response struct {
	Status string `json:"status"`
	Data   []user `json:"data"`
}
