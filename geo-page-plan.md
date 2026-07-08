# GEO-страница + бот: план реализации

> **For agentic workers:** Use superpowers:subagent-driven-development or superpowers:executing-plans to implement task-by-task.

**Goal:** Добавить страницу /geo-optimizaciya/ на aispirin.ru и ветку start=geo в diagnost_bot — новый лид-магнит для услуги GEO-оптимизации.

**Architecture:**
- Статическая HTML-страница по образцу существующих страниц сайта (ii-sotrudnik-dlya-biznesa/index.html — тот же CSS, шрифты, JSON-LD-паттерн).
- Ветка start=geo в diagnost_bot/bot.py: спрашивает домен, уведомляет Андрея, не запускает общую диагностику.
- Деплой страницы: rsync /home/agent/projects/aispirin_site/ → /var/www/aispirin/ (стандарт проекта).

**Tech Stack:** статический HTML/CSS, Python 3 (bot.py), nginx, schema.org JSON-LD

---

## Файлы

| Действие | Путь |
|---|---|
| Create | `/home/agent/projects/aispirin_site/geo-optimizaciya/index.html` |
| Modify | `/home/agent/projects/aispirin_site/sitemap.xml` |
| Modify | `/home/agent/projects/aispirin_site/llms.txt` |
| Modify | `/home/agent/projects/diagnost_bot/bot.py` (4 изменения: константа, функция, 2 блока в handle()) |

---

## Задача 1: Создать страницу geo-optimizaciya/index.html

**Файлы:**
- Create: `/home/agent/projects/aispirin_site/geo-optimizaciya/index.html`

Образец для копирования заголовка/CSS: `ii-sotrudnik-dlya-biznesa/index.html` (те же CSS-переменные, шрифты, nav, footer, CTA-секция). Ниже — все специфичные для этой страницы части.

- [ ] **Шаг 1.1: Создать папку и файл**

```bash
mkdir -p /home/agent/projects/aispirin_site/geo-optimizaciya
```

- [ ] **Шаг 1.2: Написать head (title, meta, JSON-LD)**

```html
<!doctype html>
<html lang="ru">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>GEO-оптимизация сайта: как попасть в ответы ChatGPT и Алисы</title>
  <meta name="description" content="Что такое GEO-оптимизация и чем она отличается от SEO. Чек-лист из 5 шагов для проверки своего сайта — видят ли нейросети ChatGPT, Алиса, Perplexity ваш контент при ответах клиентам." />
  <meta name="keywords" content="GEO оптимизация, GEO-оптимизация сайта, продвижение в ChatGPT, AI-поиск, продвижение в нейросетях, Яндекс Алиса поиск, GEO vs SEO" />

  <meta property="og:title" content="GEO-оптимизация: как попасть в ответы ChatGPT и Алисы — Андрей Спирин" />
  <meta property="og:description" content="Что такое GEO-оптимизация, чем отличается от SEO и как проверить свой сайт за 5 шагов." />
  <meta property="og:type" content="article" />
  <meta property="og:url" content="https://aispirin.ru/geo-optimizaciya/" />
  <meta property="og:locale" content="ru_RU" />

  <link rel="canonical" href="https://aispirin.ru/geo-optimizaciya/" />
  <link rel="icon" href="/favicon.ico" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet" />

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "GEO-оптимизация сайта: как попасть в ответы ChatGPT и Алисы",
    "description": "Что такое GEO-оптимизация, чем она отличается от SEO, и чек-лист из 5 шагов для проверки своего сайта.",
    "author": {
      "@type": "Person",
      "name": "Андрей Спирин",
      "url": "https://aispirin.ru"
    },
    "publisher": {
      "@type": "Person",
      "name": "Андрей Спирин",
      "url": "https://aispirin.ru"
    },
    "url": "https://aispirin.ru/geo-optimizaciya/",
    "mainEntityOfPage": "https://aispirin.ru/geo-optimizaciya/"
  }
  </script>

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
      {
        "@type": "Question",
        "name": "GEO-оптимизация заменит SEO?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "Нет, дополнит. Обычный поиск никуда не исчезает, но рядом появился второй канал — AI-поисковики. Компании, которые видны только в одном из двух, теряют половину потенциальных клиентов."
        }
      },
      {
        "@type": "Question",
        "name": "Нужно ли срочно что-то переделывать на сайте?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "Сначала стоит проверить, видят ли нейросети ваш контент вообще. Часто оказывается, что весь текст спрятан в браузерном рендеринге и боты видят пустую страницу."
        }
      },
      {
        "@type": "Question",
        "name": "GEO-оптимизация — это дорого?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "Базовая техническая основа делается быстро и недорого — вопрос дней, не месяцев. Объём работы зависит от того, сколько контента нужно сделать видимым нейросетям."
        }
      },
      {
        "@type": "Question",
        "name": "Это работает только для крупного бизнеса?",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "Наоборот: у небольшой компании обычно меньше контента, и привести его в порядок быстрее и дешевле, чем у крупного игрока с тысячами страниц."
        }
      }
    ]
  }
  </script>
```

- [ ] **Шаг 1.3: Скопировать CSS и nav из ii-sotrudnik-dlya-biznesa/index.html**

Взять дословно: блок `<style>` (строки 105–конец стилей) и блок `<nav>` — они одинаковы на всех страницах.

- [ ] **Шаг 1.4: Написать основной контент страницы**

После `</nav>` добавить:

```html
  <!-- HERO -->
  <section class="hero">
    <div class="container">
      <div class="hero-eyebrow">// AI-поиск и GEO</div>
      <h1 class="hero-title">GEO-оптимизация сайта:<br>
        <span class="hero-accent">как попасть в ответы ChatGPT и Алисы</span>
      </h1>
      <p class="hero-sub">
        SEO помогает попасть на первую страницу Google и Яндекса.
        GEO — Generative Engine Optimization — помогает попасть в ответ ChatGPT, Алисы или Perplexity,
        когда ваш клиент спрашивает о вашем продукте или услуге.
      </p>
    </div>
  </section>

  <!-- ЧТО ТАКОЕ GEO -->
  <section class="section">
    <div class="container">
      <h2 class="section-title">В чём разница между SEO и GEO</h2>
      <p>
        SEO борется за клик на сайт. GEO борется за то, чтобы нейросеть
        процитировала именно вас, когда отвечает клиенту напрямую — без перехода
        на сайт вообще.
      </p>
      <p style="margin-top:16px;">
        Больше половины запросов в Google сегодня заканчиваются без перехода на сайт.
        Человек получает ответ прямо от AI-ассистента и не идёт дальше. Можно стоять
        на первом месте в поиске и при этом быть невидимым для части аудитории.
      </p>
      <p style="margin-top:16px;">
        AI-поиск пока даёт меньше прямого трафика, чем обычный — но качество этого
        трафика выше. Если ChatGPT или Алиса назвали компанию по имени в ответе клиенту,
        доверие возникает до перехода на сайт. Человек приходит уже тёплым.
      </p>

      <h2 class="section-title" style="margin-top:40px;">Что нейросети учитывают при выборе источника</h2>
      <p>Логика отбора у AI-поисковиков конкретная, не случайная:</p>
      <ul class="feature-list" style="margin-top:16px;">
        <li><strong>Текст разбит на блоки «вопрос → ответ»</strong> — оттуда проще взять готовый ответ</li>
        <li><strong>Конкретные цифры и факты</strong> вместо общих фраз («экономит время» плохо, «сокращает ответ с 6 часов до 15 секунд» хорошо)</li>
        <li><strong>Личный опыт и разбор ошибок</strong> ценятся выше, чем самопрезентация</li>
        <li><strong>Структурированные данные на сайте</strong>: разметка FAQ, файл llms.txt, понятная иерархия заголовков — то, что обычный посетитель не видит, а AI-бот видит первым</li>
        <li><strong>Контент доступен без JavaScript</strong>: если текст подгружается браузером, а не отдаётся в HTML сразу — бот видит пустую страницу</li>
      </ul>
    </div>
  </section>

  <!-- ЧЕК-ЛИСТ -->
  <section class="section" style="background:var(--bg-highlight);">
    <div class="container">
      <h2 class="section-title">Чек-лист GEO-проверки сайта: 5 шагов</h2>
      <div class="steps-grid">
        <div class="step-card">
          <div class="step-num">1</div>
          <div class="step-body">
            <strong>Спросите ChatGPT или Алису напрямую про свою компанию</strong><br>
            Самый быстрый тест. Если нейросеть не знает о вас ничего — это точка отсчёта.
          </div>
        </div>
        <div class="step-card">
          <div class="step-num">2</div>
          <div class="step-body">
            <strong>Проверьте, виден ли текст сайта без JavaScript</strong><br>
            Откройте инструменты разработчика → отключите JS → обновите страницу. Весь основной текст должен остаться.
          </div>
        </div>
        <div class="step-card">
          <div class="step-num">3</div>
          <div class="step-body">
            <strong>Проверьте robots.txt — разрешены ли AI-боты</strong><br>
            Должны быть явные правила Allow для GPTBot, ClaudeBot, PerplexityBot или общий Allow: / для всех.
          </div>
        </div>
        <div class="step-card">
          <div class="step-num">4</div>
          <div class="step-body">
            <strong>Проверьте наличие llms.txt</strong><br>
            Файл /llms.txt — краткая опись содержания сайта для нейросетей. Попробуйте открыть yourdomain.ru/llms.txt.
          </div>
        </div>
        <div class="step-card">
          <div class="step-num">5</div>
          <div class="step-body">
            <strong>Проверьте структурированную разметку FAQ</strong><br>
            Страницы с разметкой FAQPage/Question/Answer напрямую сигнализируют AI: «здесь готовые ответы на вопросы».
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- КЕЙС -->
  <section class="section">
    <div class="container">
      <h2 class="section-title">Реальный пример из практики</h2>
      <p>
        У одного из клиентов — производителя строительных материалов — сайт был сделан хорошо:
        большой раздел «Академия» с терминами, 474 статьи в блоге. Но при аудите выяснилось:
        контент подгружался в браузере через JavaScript. Для AI-краулеров страница выглядела
        почти пустой. Больше трёх сотен терминов и сотни статей физически не доходили до нейросетей.
      </p>
      <p style="margin-top:16px;">
        Проблема не в качестве контента — в том, как он технически отдавался при запросе.
        Исправить это можно без переписывания ни одной статьи.
      </p>
    </div>
  </section>

  <!-- FAQ -->
  <section class="section faq-section">
    <div class="container">
      <h2 class="section-title">Частые вопросы</h2>
      <div class="faq-list">
        <div class="faq-item">
          <h3>GEO-оптимизация заменит SEO?</h3>
          <p>Нет, дополнит. Обычный поиск никуда не исчезает, но рядом появился второй канал — игнорировать его с каждым месяцем дороже.</p>
        </div>
        <div class="faq-item">
          <h3>Нужно ли срочно что-то переделывать?</h3>
          <p>Сначала проверить, видят ли нейросети ваш контент вообще. Часто весь текст спрятан в браузерном рендеринге — боты видят пустую страницу.</p>
        </div>
        <div class="faq-item">
          <h3>Это дорого и долго?</h3>
          <p>Базовая техническая основа делается за дни, не месяцы. Объём зависит от размера сайта: пять страниц или пятьсот — разный объём, но не разная сложность.</p>
        </div>
        <div class="faq-item">
          <h3>Это работает только для крупного бизнеса?</h3>
          <p>Наоборот: у небольшой компании меньше контента, привести его в порядок быстрее и дешевле.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section class="cta-section">
    <div class="container">
      <div class="cta-eyebrow">// Бесплатная проверка</div>
      <h2 class="cta-title">Пришлите домен —<br><em>Андрей лично проверит ваш сайт</em></h2>
      <p class="cta-sub">Покажу, что видят и чего не видят нейросети на вашем сайте — конкретно и без воды.</p>
      <div class="cta-btns">
        <a href="tg://resolve?domain=spirin_diagnost_bot&start=geo" class="btn-primary" target="_blank" rel="noopener">Получить проверку в Telegram →</a>
      </div>
    </div>
  </section>
```

- [ ] **Шаг 1.5: Скопировать footer из ii-sotrudnik-dlya-biznesa/index.html**

Взять дословно блок `<footer>` и закрывающие теги `</body></html>`.

**Дополнительные CSS-блоки** (добавить в `<style>` или в конец блока стилей):
```css
.steps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 16px;
  margin-top: 24px;
}
.step-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 20px;
  display: flex;
  gap: 16px;
  align-items: flex-start;
}
.step-num {
  flex-shrink: 0;
  width: 36px;
  height: 36px;
  background: var(--accent);
  color: #fff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 16px;
}
.step-body { font-size: 15px; line-height: 1.6; }
```

---

## Задача 2: Обновить sitemap.xml

**Файлы:**
- Modify: `/home/agent/projects/aispirin_site/sitemap.xml`

- [ ] **Шаг 2.1: Добавить запись перед `</urlset>`**

```xml
  <url>
    <loc>https://aispirin.ru/geo-optimizaciya/</loc>
    <priority>0.9</priority>
    <changefreq>monthly</changefreq>
  </url>
```

---

## Задача 3: Обновить llms.txt

**Файлы:**
- Modify: `/home/agent/projects/aispirin_site/llms.txt`

- [ ] **Шаг 3.1: Добавить строку в раздел «Страницы сайта»** (после строки с /about/):

```
- [GEO-оптимизация — как попасть в ответы ChatGPT и Алисы](https://aispirin.ru/geo-optimizaciya/)
```

---

## Задача 4: Деплой и проверка сайта

- [ ] **Шаг 4.1: Rsync на сервер**

```bash
rsync -av --exclude='.vercel' --exclude='.git' /home/agent/projects/aispirin_site/ /var/www/aispirin/
```
Ожидать в выводе: `geo-optimizaciya/index.html` в списке sent files.

- [ ] **Шаг 4.2: Проверить страницу открывается и title уникален**

```bash
curl -s https://aispirin.ru/geo-optimizaciya/ | grep -o '<title>[^<]*</title>'
```
Ожидаемый вывод: `<title>GEO-оптимизация сайта: как попасть в ответы ChatGPT и Алисы</title>`

НЕ должно быть: `<title>ИИ-сотрудники для бизнеса под ключ</title>` (title главной — значит nginx отдаёт главную вместо страницы).

- [ ] **Шаг 4.3: Проверить JSON-LD на странице**

```bash
curl -s https://aispirin.ru/geo-optimizaciya/ | grep -oE '"@type":\s*"[^"]*"' | sort -u
```
Ожидаемый вывод (минимум):
```
"@type": "Article"
"@type": "Answer"
"@type": "FAQPage"
"@type": "Person"
"@type": "Question"
```

- [ ] **Шаг 4.4: Проверить sitemap содержит новую страницу**

```bash
curl -s https://aispirin.ru/sitemap.xml | grep geo-optimizaciya
```
Ожидаемый вывод: `<loc>https://aispirin.ru/geo-optimizaciya/</loc>`

- [ ] **Шаг 4.5: Проверить llms.txt**

```bash
curl -s https://aispirin.ru/llms.txt | grep geo
```
Ожидаемый вывод: `- [GEO-оптимизация ...](https://aispirin.ru/geo-optimizaciya/)`

---

## Задача 5: Добавить константу состояния и функцию уведомления в bot.py

**Файлы:**
- Modify: `/home/agent/projects/diagnost_bot/bot.py`

- [ ] **Шаг 5.1: Добавить константу S_GEO_DOMAIN после S_PDF (строка ~31)**

Найти:
```python
S_PDF    = "pdf_wait"   # ждём реакции на PDF
```
Добавить после:
```python
S_GEO_DOMAIN = "geo_domain"  # ждём домен сайта (ветка start=geo)
```

- [ ] **Шаг 5.2: Добавить функцию notify_andrey_geo() после notify_andrey() (строка ~141)**

```python
def notify_andrey_geo(chat_id: int, domain: str, username: str = ""):
    """Уведомить Андрея о новом GEO-лиде (домен + Telegram-контакт)."""
    tg_link = f"@{username}" if username else f"tg://user?id={chat_id}"
    text = (
        "🟠 <b>Новый лид — GEO-аудит сайта</b>\n\n"
        f"🌐 Домен: {domain}\n"
        f"💬 Telegram: {tg_link} (id: {chat_id})"
    )
    d = urllib.parse.urlencode({
        "chat_id": ANDREY_CHAT, "text": text, "parse_mode": "HTML",
    }).encode()
    req = urllib.request.Request(
        f"https://api.telegram.org/bot{ANDREY_TOKEN}/sendMessage", data=d
    )
    try:
        urllib.request.urlopen(req, timeout=10)
    except Exception as e:
        print(f"Notify GEO error: {e}")
```

---

## Задача 6: Добавить ветку start=geo в handle()

**Файлы:**
- Modify: `/home/agent/projects/diagnost_bot/bot.py`

- [ ] **Шаг 6.1: Добавить блок перед проверкой `/start pdf` (строка ~251)**

Найти:
```python
    # /start?start=pdf — пришёл из поста канала
    if text == "/start pdf" or text.lower().startswith("/start pdf"):
```

Вставить ПЕРЕД этим блоком:

```python
    # /start?start=geo — пришёл со страницы GEO-оптимизации
    if text == "/start geo" or text.lower().startswith("/start geo"):
        STATES[chat_id] = {
            "state": S_GEO_DOMAIN,
            "data": {"tg_id": chat_id},
            "last_activity": time.time(),
        }
        send(chat_id,
             "Привет! 👋\n\n"
             "Пришлите ссылку на ваш сайт — Андрей лично проверит его по чек-листу GEO-оптимизации "
             "и пришлёт, что нейросети видят, а что нет.\n\n"
             "<i>Просто напишите домен, например: mysite.ru</i>")
        return

```

---

## Задача 7: Добавить обработчик состояния S_GEO_DOMAIN в handle()

**Файлы:**
- Modify: `/home/agent/projects/diagnost_bot/bot.py`

- [ ] **Шаг 7.1: Добавить блок обработки домена**

Найти блок `# Имя` (строка ~304):
```python
    # Имя
    if state == S_NAME:
```

Вставить ПЕРЕД ним:

```python
    # Домен для GEO-аудита
    if state == S_GEO_DOMAIN:
        domain = text.strip().lstrip("https://").lstrip("http://").rstrip("/")
        data["geo_domain"] = domain
        username = msg.get("from", {}).get("username", "")
        notify_andrey_geo(chat_id, domain, username)
        st["state"] = S_DONE
        send(chat_id,
             f"✅ Принял — <b>{domain}</b>\n\n"
             "Андрей лично посмотрит и пришлёт разбор в ближайшее время.\n\n"
             "Если есть вопросы по AI-автоматизации бизнеса — пишите, "
             "или запустите полную диагностику командой /start")
        return

```

---

## Задача 8: Перезапустить бот и проверить

- [ ] **Шаг 8.1: Найти PID текущего процесса**

```bash
pgrep -f "diagnost_bot/bot.py"
```

- [ ] **Шаг 8.2: Остановить текущий процесс**

```bash
kill $(pgrep -f "diagnost_bot/bot.py")
sleep 2
pgrep -f "diagnost_bot/bot.py"  # должно быть пусто
```

- [ ] **Шаг 8.3: Запустить по полному пути (как в watchdog.sh)**

```bash
nohup /usr/bin/python3 /home/agent/projects/diagnost_bot/bot.py >> /tmp/diagnost_bot.log 2>&1 &
sleep 3
pgrep -f "diagnost_bot/bot.py"  # должен быть ровно 1 PID
```

- [ ] **Шаг 8.4: Проверить лог на ошибки запуска**

```bash
tail -20 /tmp/diagnost_bot.log
```
Не должно быть: `SyntaxError`, `ImportError`, `Traceback`.

- [ ] **Шаг 8.5: Проверить что старый start=pdf не сломан**

```bash
curl -s "https://api.telegram.org/bot<DIAGNOST_BOT_TOKEN>/getMe"
```
Ожидаемый вывод: `{"ok":true, ...}` — бот живой.

---

## Самопроверка

**Покрытие требований из дизайна:**
- ✅ Страница /geo-optimizaciya/ с чек-листом открыто в тексте
- ✅ FAQPage/Question/Answer JSON-LD как на других страницах
- ✅ CTA с deep link start=geo
- ✅ Добавлена в sitemap.xml и llms.txt
- ✅ Ветка start=geo — только домен, без диагностики бизнеса
- ✅ Уведомление Андрею с доменом и Telegram-контактом
- ✅ Перезапуск полным путём (как watchdog.sh — pgrep по "diagnost_bot/bot.py")

**Что НЕ делаем (из дизайна):**
- ✅ Бот не делает техническую проверку домена автоматически
- ✅ Бот не переходит в общий сценарий диагностики бизнеса
