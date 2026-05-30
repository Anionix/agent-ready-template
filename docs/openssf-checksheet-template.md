# Generic OpenSSF Checksheet Template

Use this template to migrate, audit, or refresh an OpenSSF Best Practices
project without losing cleared criteria. The sheet is intentionally one row per
criterion, including rows that already pass, so future migrations can detect
stale evidence and accidental overclaims.

The editable source of truth is `templates/openssf-checksheet.template.yml`.
The machine contract is `schemas/openssf-checksheet.schema.json`, and
`examples/openssf-checksheet.example.yml` shows representative rows. CSV, HTML,
and readback JSON should be generated from a filled YAML sheet and kept under
`.cache/` unless they are intentionally committed as examples.

## Sheet columns

| Column | Required | Choices or format |
| --- | --- | --- |
| `project_id` | yes | Best Practices project id, for example `12855` |
| `target_repo` | yes | Current source repository URL |
| `track` | yes | `metal`, `osps`, `readback` |
| `level` | yes | `passing`, `silver`, `gold`, `baseline-1`, `baseline-2`, `baseline-3`, `readback` |
| `category` | yes | One of the categories below |
| `criterion_key` | yes | Exact JSON key without `_status` |
| `current_status` | yes | `Met`, `N/A`, `Unmet`, `?` |
| `target_status` | yes | `Met`, `N/A`, `Unmet`, `?` |
| `current_justification` | yes | Current saved justification, if present |
| `target_justification` | yes | New justification to save |
| `evidence_type` | yes | One of the evidence type choices below |
| `evidence_url` | no | Public evidence URL or `N/A` rationale source |
| `stale_reference` | yes | `yes`, `no` |
| `manual_proof_required` | yes | `yes`, `no` |
| `save_state` | yes | One of the save state choices below |
| `review_decision` | yes | One of the review decision choices below |
| `save_url` | no | Best Practices edit/proposal URL |
| `owner` | no | Person responsible for review/save/readback |
| `checked` | yes | `yes`, `no` |
| `notes` | no | Caveats, blockers, or manual proof notes |

## Choice sets

Use exactly these OpenSSF status values:

| Status | Meaning |
| --- | --- |
| `Met` | Criterion is satisfied |
| `N/A` | Criterion does not apply |
| `Unmet` | Criterion is not satisfied |
| `?` | Unknown or not yet reviewed |

Use these evidence type values:

| Evidence type | Use for |
| --- | --- |
| `repo_file` | Repository documentation, policy, config, source, or template file |
| `release` | Release page, artifact, checksum, signature, provenance, or changelog |
| `workflow` | CI, CodeQL, Scorecard, release, or other automation workflow evidence |
| `issue_or_pr` | Issue, pull request, review, or discussion evidence |
| `security_advisory` | Security advisory or private vulnerability report process evidence |
| `project_setting` | Repository, organization, branch protection, or platform setting |
| `manual_admin_proof` | Evidence that requires authenticated owner/admin verification |
| `not_applicable_rationale` | Scope reason for `N/A` |
| `none` | No evidence yet |

Use these save state values:

| Save state | Meaning |
| --- | --- |
| `not_started` | Row has not been reviewed |
| `drafted` | Target status/justification has been drafted |
| `opened` | Edit/proposal URL has been opened for review |
| `saved` | UI save was submitted |
| `readback_passed` | JSON readback confirms the intended value |
| `blocked` | Cannot proceed until a blocker changes |
| `deferred` | Intentionally postponed |

Use these review decision values:

| Review decision | Meaning |
| --- | --- |
| `accept` | Keep or save the drafted value |
| `revise` | Status may be right, but justification/evidence must change |
| `keep_unknown` | Keep `?` because proof is unavailable |
| `keep_unmet` | Keep `Unmet` because the criterion is truly unmet |
| `keep_na` | Keep `N/A` with a clear scope rationale |
| `defer` | Wait for manual/admin/private proof |

## Categories

| Category | Criteria to include |
| --- | --- |
| `identity` | Name, description, homepage, repository URL, public source status |
| `contribution_license` | Contribution rules, license, DCO, code of conduct |
| `repo_release` | Versioning, tags, release notes, signed releases, delivery |
| `reporting_vulnerability` | Issue tracker, vulnerability reporting, response, archive |
| `build_install_dependencies` | Build, installation, dependency, and update policy |
| `testing_quality` | Tests, CI, regression policy, coverage criteria |
| `warnings_analysis` | Warnings, static analysis, dynamic analysis, assertions |
| `security_design` | Threat model, secure design, leaked credentials, hardening, assurance |
| `crypto` | Cryptography criteria or `N/A` cryptography rationale |
| `governance_review` | Governance, roles, access continuity, bus factor, review model |
| `gold_blockers` | 2FA, unaffiliated contributors, two-person review, per-file notices |
| `osps_access_control` | `OSPS-AC-*` |
| `osps_build_release` | `OSPS-BR-*` |
| `osps_documentation` | `OSPS-DO-*` |
| `osps_governance` | `OSPS-GV-*` |
| `osps_legal` | `OSPS-LE-*` |
| `osps_quality` | `OSPS-QA-*` |
| `osps_security_assessment` | `OSPS-SA-*` |
| `osps_vulnerability_management` | `OSPS-VM-*` |
| `readback` | Final project-level readback checks |

## Default target rules

| Current condition | Default `target_status` | Default `review_decision` |
| --- | --- | --- |
| Valid current evidence | Keep current status | `accept` |
| Old repository, name, domain, or release evidence | Usually keep status and replace justification | `revise` |
| Clear public proof exists | `Met` | `accept` |
| Scope genuinely does not apply | `N/A` | `keep_na` |
| Proof unavailable | `?` | `keep_unknown` |
| Requirement is actually unmet | `Unmet` | `keep_unmet` |
| Needs private or admin-only verification | `?` until verified | `defer` |
| Gold social/governance claim is not true | `Unmet` or `?` | `keep_unmet` |

## Workflow steps

| Save step | Section | Typical rows |
| ---: | --- | --- |
| 1 | `passing/edit` | Passing and identity rows |
| 2 | `silver/edit` governance/docs | Silver governance and documentation rows |
| 3 | `silver/edit` quality/build | Silver build, install, dependency, and QA rows |
| 4 | `silver/edit` security/release | Silver security, cryptography, and release rows |
| 5 | `gold/edit` caveats | Gold review caveat rows |
| 6 | `baseline-1/edit` | OSPS Baseline 1 rows |
| 7 | `baseline-2/edit` | OSPS Baseline 2 rows |
| 8 | `baseline-3/edit` | OSPS Baseline 3 rows |
| 9 | JSON readback | Project-wide verification rows |

OSPS fields must be saved in the matching Baseline section. Do not expect an
`osps_*` field proposed on `passing/edit` to change the project record.

## Final readback rows

Always include these project-level rows even though they are not OpenSSF
criteria.

| track | level | category | criterion_key | target_status | Pass value |
| --- | --- | --- | --- | --- | --- |
| `readback` | `readback` | `identity` | `repo_url` | `Met` | Target repository URL |
| `readback` | `readback` | `identity` | `homepage_url` | `Met` | Target homepage URL |
| `readback` | `readback` | `identity` | `badge_level` | `Met` | Expected badge level |
| `readback` | `readback` | `readback` | `stale_reference_count` | `Met` | `0` |
| `readback` | `readback` | `gold_blockers` | `overclaimed_gold_count` | `Met` | `0` |
| `readback` | `readback` | `readback` | `manual_proof_pending_count` | `Met` | Known and documented |

## Row template

```csv
project_id,target_repo,track,level,category,criterion_key,current_status,target_status,current_justification,target_justification,evidence_type,evidence_url,stale_reference,manual_proof_required,save_state,review_decision,save_url,owner,checked,notes
```

Example rows:

```csv
<PROJECT_ID>,<TARGET_REPO_URL>,metal,passing,identity,repo_public,Met,Met,"<current>","Repository is public at <TARGET_REPO_URL>.",project_setting,<TARGET_REPO_URL>,no,no,drafted,accept,<SAVE_URL>,<OWNER>,no,
<PROJECT_ID>,<TARGET_REPO_URL>,osps,baseline-1,osps_access_control,OSPS-AC-01.01,?,?,"","MFA enforcement must be verified by a repository or organization admin.",manual_admin_proof,,no,yes,deferred,defer,<SAVE_URL>,<OWNER>,no,Needs admin proof before marking Met.
<PROJECT_ID>,<TARGET_REPO_URL>,readback,readback,readback,stale_reference_count,?,Met,"","No stale repository, domain, project, or release references remain in project JSON.",none,,yes,no,not_started,revise,,<OWNER>,no,
```

## JSON extraction helpers

Export all status rows:

```sh
curl -L -s "https://www.bestpractices.dev/projects/<PROJECT_ID>.json" \
  | jq -r 'to_entries[]
    | select(.key | endswith("_status"))
    | [.key, .value] | @tsv'
```

Find stale references:

```sh
curl -L -s "https://www.bestpractices.dev/projects/<PROJECT_ID>.json" \
  | jq -r 'to_entries[]
    | select((.value | type) == "string" and (.value | contains("<OLD_REFERENCE>")))
    | [.key, .value] | @tsv'
```

Count statuses:

```sh
curl -L -s "https://www.bestpractices.dev/projects/<PROJECT_ID>.json" \
  | jq -r 'to_entries[]
    | select(.key | endswith("_status"))
    | .value' \
  | sort \
  | uniq -c
```

Clean migration readback means:

- target repository and homepage fields match the intended project,
- expected badge level did not regress,
- stale reference search returns zero rows,
- manual/admin-only claims are either verified or explicitly deferred, and
- Gold claims are not marked `Met` unless the project actually satisfies them.
