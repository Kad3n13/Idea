<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Red Teaming Tool Flow</title>
</head>
<body>

  <h2>Red Teaming Tool Flow</h2>

  <table border="0" cellspacing="10" cellpadding="10">
        <tr>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>User Input</b>
                <ul>
                    <li>Target IP</li>
                    <li>Operator IP</li>
                    <li>Port</li>
                </ul>
            </td>
            <td align="center" style="font-size: 30px;">▶</td>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>AsmScan Shell</b>
                <ul>
                    <li>Validate Inputs</li>
                    <li>Prepare for Scan</li>
                </ul>
            </td>
            <td align="center" style="font-size: 30px;">▶</td>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>Nmap Execution</b>
                <ul>
                    <li>Options: `-sS`, `-sV`, `-p-`</li>
                    <li>Run Nmap Scan</li>
                </ul>
            </td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="font-size: 30px;">▼</td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 600px;">
                <b>Parse Nmap Results</b>
                <ul>
                    <li>Check for "open" services</li>
                </ul>
            </td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="font-size: 30px;">▼</td>
        </tr>

  <tr>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>Service Found?</b>
                <ul>
                    <li>Yes</li>
                    <li>No</li>
                </ul>
            </td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="font-size: 30px;">▼</td>
        </tr>

  <tr>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>Monitor Loop</b>
                <ul>
                    <li>Retry or Scan Continuously</li>
                </ul>
            </td>
            <td align="center" style="font-size: 30px;">▼</td>
            <td align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 150px;">
                <b>Reverse Shell</b>
                <ul>
                    <li>Execute `nc` for reverse shell</li>
                </ul>
            </td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="font-size: 30px;">▼</td>
        </tr>

  <tr>
            <td colspan="5" align="center" style="border: 1px solid black; border-radius: 10px; padding: 15px; width: 600px;">
                <b>Exit or Retry</b>
            </td>
        </tr>
    </table>

</body>
</html>
