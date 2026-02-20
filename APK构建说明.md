<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="正在加载理财助手应用...">
    <meta name="theme-color" content="#6366F1">
    <title>理财助手 - 加载中</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #4F46E5 0%, #8B5CF6 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            padding: 20px;
        }
        
        .container {
            max-width: 400px;
            width: 100%;
        }
        
        .logo {
            width: 120px;
            height: 120px;
            margin-bottom: 30px;
            animation: pulse 2s infinite;
        }
        
        .title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 16px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .subtitle {
            font-size: 16px;
            margin-bottom: 32px;
            opacity: 0.9;
            line-height: 1.5;
        }
        
        .loading {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        
        .spinner {
            width: 48px;
            height: 48px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        .progress-bar {
            width: 100%;
            height: 4px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 2px;
            overflow: hidden;
            margin-top: 16px;
        }
        
        .progress-fill {
            height: 100%;
            background: white;
            border-radius: 2px;
            width: 0%;
            animation: progress 3s ease-in-out infinite;
        }
        
        .offline-message {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
            display: none;
        }
        
        .retry-button {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid white;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 16px;
        }
        
        .retry-button:hover {
            background: white;
            color: #6366F1;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        @keyframes progress {
            0% { width: 0%; }
            50% { width: 70%; }
            100% { width: 100%; }
        }
        
        .version {
            position: absolute;
            bottom: 20px;
            font-size: 12px;
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="https://img.icons8.com/color/180/000000/trophy.png" alt="理财助手" class="logo">
        <h1 class="title">理财助手</h1>
        <p class="subtitle">正在加载您的个人计划与理财助手...</p>
        
        <div class="loading">
            <div class="spinner"></div>
            <div class="progress-bar">
                <div class="progress-fill"></div>
            </div>
            <p id="loading-text">正在初始化应用...</p>
        </div>
        
        <div class="offline-message" id="offline-message">
            <h3>网络连接失败</h3>
            <p>无法连接到服务器，请检查网络连接后重试</p>
            <button class="retry-button" onclick="retryLoad()">重试</button>
        </div>
    </div>
    
    <div class="version">v1.0.0</div>

    <script>
        // 应用的GitHub Pages URL
        const APP_URL = 'https://your-github-pages-url.github.io/finance-planner-app/index.html';
        
        // 加载状态文本
        const loadingTexts = [
            '正在初始化应用...',
            '正在加载资源...',
            '正在检查更新...',
            '准备就绪...'
        ];
        
        let currentTextIndex = 0;
        const loadingText = document.getElementById('loading-text');
        
        // 循环显示加载文本
        function updateLoadingText() {
            loadingText.textContent = loadingTexts[currentTextIndex];
            currentTextIndex = (currentTextIndex + 1) % loadingTexts.length;
        }
        
        setInterval(updateLoadingText, 2000);
        
        // 检查网络连接
        function checkNetwork() {
            if (navigator.onLine) {
                loadMainApp();
            } else {
                showOfflineMessage();
            }
        }
        
        // 加载主应用
        function loadMainApp() {
            console.log('正在加载主应用...');
            
            // 模拟加载延迟
            setTimeout(() => {
                if (navigator.onLine) {
                    window.location.href = APP_URL;
                } else {
                    showOfflineMessage();
                }
            }, 3000);
        }
        
        // 显示离线消息
        function showOfflineMessage() {
            document.getElementById('offline-message').style.display = 'block';
            loadingText.textContent = '网络连接失败';
        }
        
        // 重试加载
        function retryLoad() {
            document.getElementById('offline-message').style.display = 'none';
            loadingText.textContent = '正在重新连接...';
            checkNetwork();
        }
        
        // 监听网络状态变化
        window.addEventListener('online', () => {
            if (document.getElementById('offline-message').style.display === 'block') {
                retryLoad();
            }
        });
        
        window.addEventListener('offline', showOfflineMessage);
        
        // 页面加载完成后开始检查
        window.addEventListener('load', () => {
            setTimeout(checkNetwork, 1000);
        });
        
        // 防止用户意外退出
        window.addEventListener('beforeunload', (e) => {
            if (document.getElementById('offline-message').style.display === 'block') {
                e.preventDefault();
                e.returnValue = '应用正在尝试重新连接，确定要退出吗？';
            }
        });
    </script>
</body>
</html>