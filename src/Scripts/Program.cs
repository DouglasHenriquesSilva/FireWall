var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/firewall/{site}/{comando}", async context =>
{
    var site = context.Request.RouteValues["site"];
    var comando = context.Request.RouteValues["comando"];
    await context.Response.WriteAsync($"Site: {site}. Comando: {comando}.");
System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "sh";
    process.Arguments = $"/root/comandofw.sh {site} {comando}";
    process.RedirectStandardOutput = true;
    System.Diagnostics.Process cmd =  System.Diagnostics.Process.Start(process);
    cmd.WaitForExit();
});







app.Run();
