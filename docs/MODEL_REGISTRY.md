# AI Model Registry & Validation

**Source of Truth**: MCP AI Model Detector v2.1.0  
**Last Updated**: November 7, 2025  
**Total Models**: 14

## Validation Source

The model metadata (Family, Max Tokens, Capabilities) is **validated by the MCP AI Model Detector** tool, which maintains an internal registry of supported models. This data comes from:

1. **MCP Server**: ai-model-detection v2.1.0
2. **Detection Method**: VS Code internal SQLite database + Model registry
3. **Validation Tool**: `mcp_ai-model-dete_get_model_capabilities`
4. **Confidence Level**: High (sourced from official vendor specifications)

### How to Validate

```bash
# Get capabilities for a specific model
mcp_ai-model-dete_get_model_capabilities --modelId "claude-sonnet-4"

# Validate current access and list all available models
mcp_ai-model-dete_validate_model_access --includeAvailableModels true
```

## Supported Models

### Anthropic (Claude Family)

| Model ID | Display Name | Family | Max Tokens | Capabilities |
|----------|--------------|--------|------------|--------------|
| `claude-3-5-sonnet` | Claude 3.5 Sonnet | claude | 200,000 | chat, code_generation, analysis |
| `claude-3-7-sonnet` | Claude 3.7 Sonnet | claude | 200,000 | chat, code_generation, analysis |
| `claude-sonnet-4` | Claude Sonnet 4 | claude | 200,000 | chat, code_generation, analysis |

**GitHub Copilot Prefix**: `copilot/claude-sonnet-4.5` (detected version)

### OpenAI (GPT Family)

| Model ID | Display Name | Family | Max Tokens | Capabilities |
|----------|--------------|--------|------------|--------------|
| `gpt-4.1` | GPT-4.1 | gpt | 128,000 | chat, code_generation |
| `gpt-4o` | GPT-4o | gpt | 128,000 | chat, code_generation |
| `gpt-5` | GPT-5 | gpt | 256,000 | chat, code_generation, advanced_reasoning |
| `gpt-5-mini` | GPT-5 mini | gpt | 128,000 | chat, code_generation |

**GitHub Copilot Prefix**: `copilot/gpt-4o`, `copilot/gpt-4`

### OpenAI (O-Series - Reasoning Models)

| Model ID | Display Name | Family | Max Tokens | Capabilities |
|----------|--------------|--------|------------|--------------|
| `o1-preview` | o1-preview | o-series | 128,000 | chat, advanced_reasoning |
| `o1-mini` | o1-mini | o-series | 65,000 | chat, reasoning |
| `o3-mini` | o3-mini | o-series | 65,000 | chat, reasoning |

### Google (Gemini Family)

| Model ID | Display Name | Family | Max Tokens | Capabilities |
|----------|--------------|--------|------------|--------------|
| `gemini-2.5-pro` | Gemini 2.5 Pro | gemini | 2,000,000 | chat, code_generation, multimodal |
| `gemini-2.5-flash` | Gemini 2.5 Flash | gemini | 1,000,000 | chat, code_generation, multimodal |

### xAI (Grok Family)

| Model ID | Display Name | Family | Max Tokens | Capabilities |
|----------|--------------|--------|------------|--------------|
| `grok-code-fast-1` | Grok Code Fast 1 | grok | 128,000 | chat, code_generation |
| `grok-2` | Grok 2 | grok | 128,000 | chat, code_generation |

## Capability Definitions

| Capability | Description |
|------------|-------------|
| `chat` | Conversational AI, question answering |
| `code_generation` | Writing, completing, and modifying code |
| `analysis` | Advanced reasoning and analytical tasks |
| `advanced_reasoning` | Complex problem-solving, multi-step logic |
| `reasoning` | Logical deduction and inference |
| `multimodal` | Text, image, and other media processing |

## Common Use Cases

All models support:
- Chat and conversation
- Code generation and completion
- Analysis and reasoning
- Multi-language support

## GitHub Copilot Model Detection

When using GitHub Copilot, models are detected with the `copilot/` prefix:

**Detection vs Registry Mapping:**
- Detected: `copilot/claude-sonnet-4.5` → Registry: `claude-sonnet-4`
- Detected: `copilot/gpt-4o` → Registry: `gpt-4o`
- Detected: `copilot/gpt-4` → Registry: `gpt-4.1`

### Known Discrepancies

| Detected ID | Reported Tokens | Registry ID | Registry Tokens | Notes |
|-------------|-----------------|-------------|-----------------|-------|
| `copilot/claude-sonnet-4.5` | 100,000 | `claude-sonnet-4` | 200,000 | Copilot may report conservative limit |
| `copilot/gpt-4o` | 128,000 | `gpt-4o` | 128,000 | ✅ Consistent |

**Explanation**: The `copilot/` prefixed detection reads from VS Code's internal database, which may use conservative token limits or different versioning than the canonical model registry.

## Email Mapping for Attribution

Use normalized model IDs for deterministic email generation:

```
admin+llm-[normalized-model-id]@emblemprojects.com
```

### Examples:

| Detected Model | Normalized ID | Email |
|----------------|---------------|-------|
| `copilot/claude-sonnet-4.5` | `claude-sonnet-4-5` | `admin+llm-claude-sonnet-4-5@emblemprojects.com` |
| `copilot/gpt-4o` | `gpt-4o` | `admin+llm-gpt-4o@emblemprojects.com` |
| `copilot/o1-preview` | `o1-preview` | `admin+llm-o1-preview@emblemprojects.com` |

## Updating This Registry

This file should be regenerated when:
1. MCP AI Model Detector is updated
2. New models are added to GitHub Copilot
3. Token limits or capabilities change

### Update Command:
```bash
# Validate current model access and registry
mcp_ai-model-dete_validate_model_access --includeAvailableModels true

# Query specific model capabilities
mcp_ai-model-dete_get_model_capabilities --modelId "<model-id>"
```

## References

- **MCP Tool**: ai-model-detection v2.1.0
- **Detection Confidence**: High
- **Source**: Official vendor specifications (Anthropic, OpenAI, Google, xAI)
- **Attribution Standard**: GIT-ATT-001 v1.1.0
- **Project**: tech-stack-stickers

---

**Note**: Always use `mcp_ai-model-dete_detect_current_model` before making attributed commits. This registry is for reference only - detection tools provide the authoritative current state.
