var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/firewall/{site}/{comando}", async context =>
{
    var site = context.Request.RouteValues["site"].ToString();
    var comando = context.Request.RouteValues["comando"].ToString();

    System.Diagnostics.ProcessStartInfo process = new System.Diagnostics.ProcessStartInfo();
    process.UseShellExecute = false;
    process.WorkingDirectory = "/bin";
    process.FileName = "sh";
    process.Arguments = $"/root/comandofw.sh {site} {comando}";
    process.RedirectStandardOutput = true;

    System.Diagnostics.Process cmd = System.Diagnostics.Process.Start(process);
    cmd.WaitForExit();

    string output = await cmd.StandardOutput.ReadToEndAsync();

    await context.Response.WriteAsync("<!doctype html>");
    await context.Response.WriteAsync("<html lang='pt-br'>");
    await context.Response.WriteAsync("<head>");
    await context.Response.WriteAsync("<meta charset='UTF-8'>");
    // Definindo o título da página
    await context.Response.WriteAsync("<title>SITE LIBERADO OU BLOQUEADO</title>");
    await context.Response.WriteAsync("</head>");
    await context.Response.WriteAsync("<body>");
    // Adicionando a tag <img> para exibir a imagem
    await context.Response.WriteAsync("<img src=\"/root/webserver/igarape.jpg\">");
    await context.Response.WriteAsync("<img src=\"/home/douglas/Imagens/igarape.jpg\" alt=\"A imagem não aparece\">");

    string status;
    if (comando == "DROP")
    {
        status = "Bloqueado";
    }
    else if (comando == "ACCEPT")
    {
        status = "Liberado";
    }
    else
    {
        status = "desconhecido";
    }

    await context.Response.WriteAsync($"<h1>O SITE: <font color=\"red\"><strong>{site}</strong></font> FOI: <font color=\"red\"><strong>{status}</strong></font></h1>");

    await context.Response.WriteAsync("<h2>--------------------------------------------------------------------</h2>");
    await context.Response.WriteAsync("<h1>Relatório de sites bloqueados:</h1>");

    // Adicionando o comando para gerar o relatório de sites bloqueados
    process.Arguments = "-c \"iptables-save | grep -E 'OUTPUT.*-m string.*--string' | awk '{print $12}'\"";
    cmd = System.Diagnostics.Process.Start(process);
    cmd.WaitForExit();
    output = await cmd.StandardOutput.ReadToEndAsync();

    await context.Response.WriteAsync("<pre>" + output + "</pre>");

    // Adicionando o JavaScript para retornar à página anterior após 5 segundos
    await context.Response.WriteAsync("<script>");
    await context.Response.WriteAsync("setTimeout(function(){ history.back(); }, 5000);");
    await context.Response.WriteAsync("</script>");

    await context.Response.WriteAsync("</body>");
    await context.Response.WriteAsync("</html>");
});

app.Run();

