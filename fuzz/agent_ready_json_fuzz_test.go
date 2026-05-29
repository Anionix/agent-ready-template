package fuzz

import (
	"encoding/json"
	"testing"
)

type readinessJSON struct {
	Status   string          `json:"status"`
	Score    int             `json:"score"`
	Checks   int             `json:"checks"`
	Failures int             `json:"failures"`
	Findings []readinessItem `json:"findings"`
}

type readinessItem struct {
	Status string `json:"status"`
	Name   string `json:"name"`
	Detail string `json:"detail"`
}

func FuzzAgentReadyJSONCompatibility(f *testing.F) {
	f.Add([]byte(`{"status":"pass","score":100,"checks":1,"failures":0,"findings":[{"status":"ok","name":"sample","detail":"passed"}]}`))
	f.Add([]byte(`{"status":"fail","score":95,"checks":2,"failures":1,"findings":[{"status":"fail","name":"sample","detail":"failed"}]}`))
	f.Add([]byte(`not json`))

	f.Fuzz(func(t *testing.T, payload []byte) {
		_ = acceptsAgentReadyJSON(payload)
	})
}

func acceptsAgentReadyJSON(payload []byte) bool {
	var doc readinessJSON
	if err := json.Unmarshal(payload, &doc); err != nil {
		return false
	}

	if doc.Status != "pass" && doc.Status != "fail" {
		return false
	}
	if doc.Score < 0 || doc.Score > 100 {
		return false
	}
	if doc.Checks < 0 || doc.Failures < 0 || doc.Failures > doc.Checks {
		return false
	}

	for _, finding := range doc.Findings {
		switch finding.Status {
		case "ok", "fail", "skipped":
		default:
			return false
		}
	}

	return true
}
