import express from "express";

const offerRoute = express.Router();

offerRoute.get("/", (req, res) => {});

offerRoute.get("/:id", (req, res) => {});

offerRoute.post("/", (req, res) => {});

offerRoute.patch("/:id", (req, res) => {});

offerRoute.delete("/:id", (req, res) => {});

export default offerRoute;
