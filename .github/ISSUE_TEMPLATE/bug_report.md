---
name: 闪退 / 无法运行反馈
about: 反馈 OpenRA Switch 版（大气层）崩溃、闪退或无法运行
title: "[崩溃] 简短描述问题现象"
labels: bug
assignees: ''
---

## 现象（勾选最接近的）

- [ ] 启动即闪退
- [ ] 加载画面闪退（停在哪句台词？如 Splitting Atoms / Building Bridges）
- [ ] 进入主界面后闪退（执行了什么操作？如点遭遇战 / 战役 / 设置）
- [ ] 黑屏 / 无响应
- [ ] 其他：________________

## 环境

- 大气层版本：________（如 1.7.0）
- 固件版本：________（如 18.1.0）
- 包版本：________（如 v1.0 或下载日期）
- 安装方式：SD 卡覆盖 / NSP 前端直达 / 其他

## 日志（必填，打包成 zip 上传）

请从 SD 卡收集以下内容（通常在根目录 `mono/openra/` 下）并附到本 Issue：

1. `mono/openra/Support/Logs/` 整个目录（含 log.txt、debug.log、exception-*.log）
2. `mono/openra/unhandled.log`（若存在，程序崩溃时的兜底日志）
3. `mono/openra/log.txt`（若与上面不同）

## 截图

卡住 / 闪退瞬间的屏幕照片（如有）

## 复现步骤

1. 启动 OpenRA
2. ...
3. ...

## 备注

- 是否删除过 `mono/openra/Support/settings.yaml` 后重试？（升级后旧设置可能覆盖新默认值）
