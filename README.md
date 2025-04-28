
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
<img Screenshot 2025-04-28 063837.png</img>
