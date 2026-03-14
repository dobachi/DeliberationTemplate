# AI Development Support Configuration

This project uses the AI instruction system in `instructions/ai_instruction_kits/`.
Please load `instructions/ai_instruction_kits/instructions/en/system/ROOT_INSTRUCTION.md` when starting a task.
ROOT_INSTRUCTION.md serves as the skill orchestrator. Check installed skills in `.claude/skills/` and use them as needed for the task.

Skill Marketplace: <https://github.com/dobachi/AI_Instruction_Kits/tree/main/templates/claude-skills>

## Project Settings
- Purpose: Documentation of deliberations, strategies, and considerations
- Language: English (en)
- Checkpoint Management: Enabled
- Checkpoint Script: scripts/checkpoint.sh
- Log File: checkpoint.log

## Important Paths
- AI Instruction System: `instructions/ai_instruction_kits/`
- Checkpoint Script: `scripts/checkpoint.sh`
- Project-Specific Configuration: This file (`instructions/PROJECT.en.md`)

## Commit Rules
- **Required**: `bash scripts/commit.sh "message"` or `git commit -m "message"`
- **Prohibited**: AI-signed commits (auto-detected and rejected)

## Project-Specific Instructions

### Document Focus
This template is designed for documenting:
- Strategic analysis and decision-making processes
- Options comparison and trade-off analysis
- Consideration records with supporting evidence
- Technology evaluation and selection rationale

### Quality Standards
- Clear separation of facts (from research) and analysis/opinions
- Logical consistency from problem definition to conclusion
- Multiple perspectives and stakeholder analysis
- Explicit decision criteria and judgment rationale
