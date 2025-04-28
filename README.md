<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Red Teaming Tool Flow</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            color: #333;
        }
        h1, h2 {
            text-align: center;
            color: #6a0dad; /* Dark Purple */
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 15px;
        }
        td {
            border: 1px solid #333;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            vertical-align: top;
            background-color: #fff;
        }
        .arrow {
            font-size: 30px;
            color: #32cd32; /* Neon Green */
        }
        pre {
            background-color: #333;
            color: #f4f4f4;
            padding: 15px;
            border-radius: 8px;
            overflow-x: auto;
            text-align: left;
        }
        .section-header {
            background-color: #6a0dad; /* Dark Purple */
            color: #fff;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        ul li {
            margin: 5px 0;
        }
    </style>
</head>
<body>

<h1>Red Teaming Tool Flow</h1>
    <h2>Process Overview</h2>

<div class="section-header">User Input</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li><strong>Target IP</strong></li>
                    <li><strong>Operator IP</strong></li>
                    <li><strong>Port</strong></li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>AsmScan Shell</strong></li>
                    <li>Validate Inputs</li>
                    <li>Prepare for Scan</li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>Nmap Execution</strong></li>
                    <li>Options: <code>-sS, -sV, -p-</code></li>
                    <li>Run Full Nmap Scan</li>
                </ul>
            </td>
        </tr>
</table>

<div class="section-header">Parse Nmap Results</div>
    <table>
        <tr>
            <td colspan="5">
                <ul>
                    <li>Check for "open" services</li>
                </ul>
            </td>
        </tr>
    </table>

<div class="section-header">Service Found?</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li>Yes → <strong>Reverse Shell</strong></li>
                    <li>No → <strong>Monitor Loop</strong></li>
                </ul>
            </td>
        </tr>
    </table>

 <div class="section-header">Monitor Loop</div>
    <table>
        <tr>
            <td>
                <ul>
                    <li>Retry or Scan Continuously</li>
                </ul>
            </td>
            <td class="arrow">▶</td>
            <td>
                <ul>
                    <li><strong>Reverse Shell</strong></li>
                    <li>Execute <code>nc</code> (netcat) for shell</li>
                </ul>
            </td>
        </tr>
    </table>

<div class="section-header">Exit or Retry</div>

<h2>🔧 Example Code Snippet</h2>
    <pre>
# Simple Nmap Scan Example
nmap -sS -sV -p- $TARGET_IP -oN scan_results.txt
    </pre>

</body>
</html>
