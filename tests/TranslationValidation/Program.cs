using OpenRA;
using System.Text.RegularExpressions;

if (args.Length != 1) throw new ArgumentException("Pass translations directory.");
var root = Path.GetFullPath(args[0]);
var errors = new List<string>();
var bundles = new Dictionary<string, FluentBundle>();
foreach (var relative in new[] { "common-fluent/common.ftl", "common-fluent/rules.ftl", "ra-fluent/rules.ftl", "ra-fluent/chrome.ftl" })
{
    var bundle = new FluentBundle("en", File.ReadAllText(Path.Combine(root, relative)), error => errors.Add(relative + ": " + error.Message));
    bundles[relative] = bundle;
}
if (errors.Count != 0) throw new Exception(string.Join("\n", errors));
var ra = bundles["ra-fluent/rules.ftl"];
foreach (var (key, expected) in new[] {
    ("actor-mslo.name", "核弹发射井"), ("actor-spen.name", "潜艇船坞"),
    ("actor-syrd.name", "船厂"), ("actor-silo.name", "储矿仓"),
    ("actor-stek.name", "苏军科技中心"), ("actor-fact.name", "建造厂"),
    ("actor-e6.name", "工程师"), ("actor-e7.name", "谭雅"),
    ("actor-fpwr.name", "伪装发电厂"), ("bot-normal-ai.name", "标准型电脑") })
    if (ra.GetMessage(key) != expected) throw new Exception(key + " mismatch");
var common = bundles["common-fluent/common.ftl"];
if (common.GetMessage("options-game-speed.normal") != "正常") throw new Exception("Speed translation mismatch");
foreach (var minutes in new[] { 1, 30 })
{
    var message = common.GetMessage("options-time-limit.options", new object[] { "minutes", minutes });
    if (!message.Contains("分钟") || message.Contains("minute")) throw new Exception("Plural resolution failed: " + message);
}
if (bundles["common-fluent/rules.ftl"].GetMessage("checkbox-fog-of-war.label") != "战争迷雾") throw new Exception("Lobby option mismatch");
if (bundles["ra-fluent/chrome.ftl"].GetMessage("button-command-bar-force-move.tooltip") != "强制移动") throw new Exception("Chinese tooltip overridden");
// Every RA rule value must contain Chinese; IDs and comments are deliberately excluded.
foreach (var line in File.ReadLines(Path.Combine(root,"ra-fluent/rules.ftl")))
{
    if (line.TrimStart().StartsWith("#")) continue;
    if (line.TrimEnd().EndsWith("=")) continue;
    var value = line.Contains(" = ") ? line[(line.IndexOf(" = ") + 3)..] : line.Trim();
    if (Regex.IsMatch(value,"[A-Za-z]{3}") && !Regex.IsMatch(value,"[\\u4e00-\\u9fff]")) throw new Exception("Untranslated RA rule: " + line);
}
Console.WriteLine("PASS: four Fluent files parse; building/unit/AI names, lobby labels, plural time limits and tooltips resolve in the game localization engine; no English-only RA rule values remain.");
