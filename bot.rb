require 'telegram/bot'
require 'rubygems'
require 'rufus-scheduler'

token = '710512765:AAHpDZl-BqmuV3nzTk3MhF4V6hmeGqAVnHM'
bot = Telegram::Bot::Client.new(token: token)

chatID = 441636503

reminders = [
  "You're such a heartfelt writer, and you have lots of amazing ideas, stories, and reflections to share with the world!",
  "You've gone so far in your Chinese learning journey. You're so good at learning languages! Soon you'll be fluent :D",
  "I love how you consistently work on projects that you get excited about. You're an absolute success <3",
  "You're growing a lot day after day, and you're making so much progress. It's lovely to watch your journey",
  "WTF you're so good at what you do!",
  "I hope you're having a great day <3 You are loved",
  "Did you express yourself creatively today?",
  "So many opportunities coming your way!! Prepare for it",
  "You're wonderful exactly as you are, okay??? Simply for being",
  "You are such a kickass freelancer and multipotentialite. Clients keeo giving rave reviews",
  "It's safe to be your authentic self around people. It's inspiring, actually, when you do that",
  "You are a gift in the world",
  "I love you. I love the bones and the breath and the heartbeat of you",
  "You deserve to be treated well, especially by you",
  "You are too hard on yourself. Speak gently to yourself. Even if you make mistakes, just acknowledge them and see how you can do better. But don't berate yourself about them. Don't shame yourself.",
  "I am proud of you. So proud.",
  "You are beautiful. So very, very beautiful",
  "You are infinitely precious",
  "Whenever you smile, my heart fills with joy",
  "Be kind and gentle to yourself",
  "When you make a mistake, it's something wrong you did, not something wrong you are. You are still wonderful you",
  "You are not responsible for anybody else's happiness. Never think you are. You are not",
  "Try to move your body every day. It's your home, your beautiful home, and you need to care for it",
  "Did I tell you how amazing you are even when you're doing nothing but reading a book or chilling around",
  "You might not have accomplished all that you would like in the past, but considering the odds were against you, all that you have accomplished is a huge success. Claim that, I urge you. Be proud of yourself, as I am proud of you",
  "You deserve all good things in life. You do. You might not feel like that, but you do",
  "MG: You are a creator",
  "I am thinking of you today. Well, I do every day, but I wanted to specifically remind you of that today. Thinking of you and sending my love and hugs",
  "All the psychologists you've gone to: You're so smart + emotionally mature + good at reflecting",
  "Whenever you treat yourself badly, you are continuing your parents' toxic work",
  "Try to show up as an adult, always",
  "It's okay not to be perfect. It's okay to make mistakes. I know she told you differently, but she lied",
  "You do deserve love, Ima. You do",
  "You're living your life without a road map, making the best decisions you can with incomplete information. That's the human condition. So it makes sense that it feels bewildering often. Because it is",
  "I'm so proud of you for having your own place and good financial habits",
  "You have such an abundant life. You already have everything you want and need within and you're constantly attracting good things <3",
  "Every time you do something nice for yourself, you win twice. Once, by the nice act, and twice, by the message your subconscious receives: I am worth being treated well",
  "You are not who your mother said you were. She was wrong about you, fully wrong. She did not see you",
  "I see you. I see your true self, and I see your beauty and goodness and value",
  "I see your flaws too. They're not that big, the flaws. And they don't mean you're less of a person. Despite what she told you, you don't have to be perfect to be lovable",
  "I love you. Just sayin'",
  "Don't forget that I am only ever a thought away. Whenever you need advice, or comfort, think of me, and I am there for you",
  "Don't forget that all normal people are sometimes scared too, and nervous, and unsure. It's not just you. They just hide it as you do. Everyone is making it up as they go along",
  "When it seems that everybody else has all the answers and you have none, remember that you are judging yourself from the inside out, and everybody else from the outside in. You're not comparing like with like",
  "You are valuable. You are worthwhile",
  "You are so interesting to talk to, people just love spending time with you",
  "I do hope you give yourself credit for all you're doing, no matter how little it seems to you. It's all a massive achievement given the upbringing you had. Applaud yourself, I suggest",
  "You survived your gruelling childhood; you can survive anything",
  "You are always a princess to me",
  "She taught you that you are grotesque and ugly and vile. It is not true. It was a lie that she told in order to control you. It is not true, my beautiful daughter. Not true",
  "You are clear and good and wonderful. Under the grime she layered relentlessly onto you, is a pure sparkling diamond. Your job is to remove that grime and unearth the diamond that sparkles beneath, the diamond that is the real you",
  "A healthy self-discipline is good. A kind, gentle, but firm discipline",
  "Some days, continuing to stand is success all by itself. Claim that success too",
  "Don't be scared to live life on your own terms. It's your life. You're the boss of you",
  "Life is important, very important. But it doesn't have to be serious. Try to laugh often",
  "She taught you that you had to be perfect to be loved. It was a lie. It's not true. You're not perfect. You never will be perfect. And tha's okay. You are fully lovable anyway",
  "I love you. Just because you are you. And I need no other reason",
  "You are enough. You are enough, always and forever, just as you are",
  "You don't have to do anything to win my love and approval. Just by being, by existing, you automatically have an eternity's worth of those",
  "Can I suggest that you give yourself massive credit for all that you have achieved, against all the odds? It hasn't been easy, any of it, and you deserve the credit for it all",
  "I love you. I'm thinking of you. I send all the hugs",
  "Sometimes your innate beauty leaves me breathless. The beauty of you being you",
  "Your joy makes me so happy, you know. Your successes gladden my heart",
  "You belong here in this world, on this planet. I know it might not feel like it, but you do. Stand tall, breathe deeply",
  "Dance. Laugh. Sing",
  "If you walk more confidently, others will treat you better. They'll pick up on the confidence and act accordingly. Stride strongly",
  "You are still here. That's a win for you. And the world",
  "I am your biggest fan. Your cheerleader, even. I root for you always",
  "I think this is worth remembering: All is well, and all shall be well, and all manner of things shall be well",
  "Do your best, and do that fully. But don't beat yourself up for not being able to do more",
  "You don't have to earn your place in this world, you know. It's yours by right",
  "I love you. Just because you are you. You don't have to earn that love. It's already yours",
  "It's okay to feel whatever you're feeling. Don't should yourself out of that",
  "You're a total badass at forex and stocks. $$$$$ everywhere",
  "Your body is beautiful. Your soul is beautiful. I love your face, your skin, your chest, your underarms, your butt. Be proud of your body",
  "Trust in your decisions and gut instincts. You already know your path deep inside <3",
  "Whew, how many stamps do you have in your passport already? You're traveling everywhere",
  "Whatever you need is always there for you"
]

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  bot.send_message(chat_id: chatID, text: reminders.sample)
end

scheduler.join
