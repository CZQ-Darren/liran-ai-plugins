# 理然企业 AI 插件市场

理然内部 ChatGPT / Codex 插件市场。当前首批包含：

- **理然BI数仓**：连接 `https://mcp.liran-ai.com/mcp/data/`
- **理然知识库**：连接 `https://mcp.liran-ai.com/mcp/knowledge/`

## 仓库结构

```text
.agents/plugins/marketplace.json
plugins/
  liran-bi-warehouse/
    .codex-plugin/plugin.json
    .mcp.json
    skills/liran-bi-warehouse/SKILL.md
  liran-knowledge-base/
    .codex-plugin/plugin.json
    .mcp.json
    skills/liran-knowledge-base/SKILL.md
```

## 导入 Workspace

在 ChatGPT Workspace 管理后台进入 **Settings → Plugins → Add → Import marketplace**，Source 填仓库根地址：

```text
https://github.com/CZQ-Darren/liran-ai-plugins
```

Path 留空，Branch 留空即可跟随默认分支。导入后分别配置两个插件的安装策略和认证策略。

## 当前兼容性说明

当前 v0.1.0 为可直接连接远程 MCP 的版本，因此插件声明了 `.mcp.json`。按 OpenAI 当前规则，这类插件在 ChatGPT Web 中会显示 **Desktop only**；Codex / 支持 MCP 的桌面运行面可以直接使用。

如果需要 ChatGPT Web 原生可用，应将 Workspace 中现有的“BI数据库”和“飞书知识库”App ID 写入各插件根目录 `.app.json`，然后在 `plugin.json` 中改为引用 `apps`，并移除 `mcpServers`。这样继续复用同一套 MCP 服务，但由 Workspace App 承担 Web 端连接与 OAuth。

## 更新规则

- MCP 服务端代码、权限、指标和知识检索逻辑更新：直接部署 `liran-mcp-gateway`，通常不需要更新本仓库。
- Skill、插件名称、说明、默认提示或插件绑定关系更新：修改本仓库并提交到默认分支。
- Workspace 导入后默认每日同步 GitHub Marketplace；管理员也可手动触发同步。

## 安全边界

- 本仓库不得提交飞书 Token、数据库密码、OAuth Secret 或其他生产密钥。
- 数据权限、行权限、字段权限仍由 `liran-mcp-gateway` 服务端统一执行。
- 插件和 Skill 只定义入口及使用方式，不扩大用户原有数据权限。
