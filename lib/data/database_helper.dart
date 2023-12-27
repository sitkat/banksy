import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'banksy.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE News (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageId TEXT,
            name TEXT,
            description TEXT,
            author TEXT,
            authorImage TEXT,
            date TEXT,
            takesTime TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Community (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageId TEXT,
            name TEXT,
            description TEXT,
            author TEXT,
            authorImage TEXT,
            date TEXT,
            takesTime TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Income (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            description TEXT
          )
        ''');

        await db.insert('Community', {
          'imageId': '2Jjq1O_2_pc',
          'name': 'The Problem With Indian Economy | Indian Economy | Econ',
          'description':
              'The Indian economy is grappling with various challenges that have impeded its growth trajectory. Issues such as unemployment, income inequality, and the impact of global economic fluctuations pose significant hurdles, requiring comprehensive policy measures for sustainable economic development in India.',
          'author': 'Econ',
          'authorImage': 'assets/communities/author1.jpg',
          'date': '2023-02-14',
          'takesTime': '11 mins'
        });
        await db.insert('Community', {
          'imageId': 'EJHPltmAULA',
          'name':
              'Explore the essential principles of Finance and Economics crucial for businesses in our comprehensive Crash Course, covering topics from budgeting strategies to market analysis, equipping you with the foundational knowledge needed to navigate the dynamic world of business finance.',
          'description': 'Delve into the fundamental tenets of Finance and Economics with our extensive Crash Course, designed to impart essential knowledge for businesses.Our comprehensive program explores critical aspects of Finance and Economics, ranging from effective budgeting strategies to in-depth market analysis, ensuring you acquire foundational expertise for navigating the dynamic realm of business finance.Uncover key principles in Finance and Economics through our thorough Crash Course, encompassing a wide array of topics such as budgeting strategies and market analysis.',
          'author': 'freeCodeCamp.org',
          'authorImage': 'assets/communities/author2.jpg',
          'date': '2023-09-12',
          'takesTime': '1 h 38 mins'
        });
        await db.insert('Community', {
          'imageId': '5vZjrxE8Wlc',
          'name': '7 Passive Income Ideas - How I Make \$67k per Week',
          'description':
              'Exploring various passive income streams has been a game-changer for me, allowing me to generate a weekly income of \$67k effortlessly through innovative investment strategies and online ventures.',
          'author': 'Mark Tilbury',
          'authorImage': 'assets/communities/author3.jpg',
          'date': '2023-05-09',
          'takesTime': '26 mins'
        });
        await db.insert('Community', {
          'imageId': 'XCubeZwEdrk',
          'name': 'The market rally will continue to run, says Veritas Financial\'s Greg Branch',
          'description':
          'Greg Branch, founder and managing partner at Veritas Financial Group, joins Power Lunch to discuss the trajectory of the latest market rally, the likelihood of Fed rate cuts, and more.',
          'author': 'CNBC Television',
          'authorImage': 'assets/communities/author4.jpg',
          'date': '2023-12-26',
          'takesTime': '4 mins'
        });
        await db.insert('Community', {
          'imageId': 'Cygvg9oeE7E',
          'name': 'Bitcoin has already priced in spot ETF approval: Expert',
          'description':
          'Crypto investors of all sorts are patiently waiting on spot bitcoin ETF approval from the Securities and Exchange Commission, with the price of bitcoin (BTC-USD) soaring in anticipation of the potential sign off. Dinara Co-Founder & CEO Laurence Latimer joins Yahoo Finance to discuss what would happen both immediately, and down the line, if the ETF is approved and how other cryptocurrencies can benefit from it.',
          'author': 'Yahoo Finance',
          'authorImage': 'assets/communities/author5.jpg',
          'date': '2023-12-26',
          'takesTime': '7 mins'
        });
        await db.insert('Community', {
          'imageId': 'VDqAww1Dby0',
          'name': 'It Started: The Reverse Market Crash Of 2024',
          'description':
          'A "market crash" typically refers to a sudden and severe decline in the prices of securities, such as stocks, bonds, or commodities, often resulting in panic selling and a sharp decrease in overall market value. Investors may use various terms to describe a recovery or improvement in market conditions, such as a "market rebound" or "market recovery."',
          'author': 'Graham Stephan',
          'authorImage': 'assets/communities/author6.jpg',
          'date': '2023-11-16',
          'takesTime': '12 mins'
        });
        await db.insert('Community', {
          'imageId': '3fGxOuTZacw',
          'name': 'Here\'s why Americans can\'t keep money in their pockets — even when they get a raise',
          'description':
          'More than half of Americans earning more than \$100,000 a year say they\'re living paycheck to paycheck, according to a report from PYMNTS and LendingClub. This may be a result of a sneaky behavioral phenomenon called lifestyle creep, which is when a person\'s spending habits expand as their income rises. The rise in the cost of living complicates matters, as incomes have not kept up with inflation. Watch the video above to learn more about why Americans struggle to keep money in their pockets.',
          'author': 'CNBC Television',
          'authorImage': 'assets/communities/author4.jpg',
          'date': '2023-12-11',
          'takesTime': '9 mins'
        });
        await db.insert('Community', {
          'imageId': 'dT8c0fXs3Bg',
          'name': 'I rarely recommend buying stocks straight off the new high list, says Jim Cramer',
          'description':
          '\'Mad Money\' host Jim Cramer shares his tools of the trade for investing.',
          'author': 'CNBC Television',
          'authorImage': 'assets/communities/author4.jpg',
          'date': '2023-12-27',
          'takesTime': '12 mins'
        });
        await db.insert('Community', {
          'imageId': '92fMNWCcPuc',
          'name': 'Solana nears \$100 as the crypto token extends rally: CNBC Crypto World',
          'description':
          'CNBC Crypto World features the latest news and daily trading updates from the digital currency markets and provides viewers with a look at what\'s ahead with high-profile interviews, explainers, and unique stories from the ever-changing crypto industry. On today\'s show, crypto experts explain the pros and cons of investing in a crypto-focused stock, like Coinbase, compared to investing in the token itself.',
          'author': 'CNBC Television',
          'authorImage': 'assets/communities/author4.jpg',
          'date': '2023-12-22',
          'takesTime': '10 mins'
        });
        await db.insert('Community', {
          'imageId': 'Iym6enpfPNQ',
          'name': 'Lightning Round: EQT is a winner, says Jim Cramer',
          'description':
          '\'Mad Money\' host Jim Cramer weighs in on stock including: Occidental Petroleum, SoFi, EQT and Nu Holdings.',
          'author': 'CNBC Television',
          'authorImage': 'assets/communities/author4.jpg',
          'date': '2023-12-22',
          'takesTime': '3 mins'
        });



        // News
        await db.insert('News', {
          'imageId': 'assets/news/image/news1.jpg',
          'name':
              'Where Did All the Money Go? The Villain in Your Transaction History',
          'description':
              'If you want to rein in your spending in 2024, financial advisers say you first need to sort out where inflation ends and lifestyle creep begins.',
          'author': 'Julia Carpenter',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '6 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news2.jpg',
          'name':
          'A Yearlong Way to Boost Stock-Market Returns',
          'description':
          'Investors generally wait too long to harvest tax losses from their portfolios, leaving billions on the table. In the world of investing, it\'s a common tendency for investors to procrastinate when it comes to harvesting tax losses from their portfolios. Unfortunately, this delay often results in substantial amounts of money being left on the table. The practice of tax-loss harvesting involves strategically selling investments at a loss to offset capital gains, thereby reducing the overall tax liability. However, the failure to act promptly on this strategy means that potential tax advantages go unrealized, costing investors billions in potential savings. Successful investors recognize the importance of timely tax management as an integral part of their overall investment strategy.',
          'author': 'Spencer Jakab',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '2 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news3.jpg',
          'name':
          'Banking Crisis Plays Out at America’s Smallest Lenders',
          'description':
          'Rural community banks face a significant threat due to extensive underwater bond portfolios held by larger financial entities. The vulnerability stems from the potential risks associated with these portfolios, including the adverse impact of economic downturns or fluctuations in the bond market. The exposure to underwater bonds, where the market value of the bonds falls below their face value, poses challenges to the financial stability of rural community banks. These risks can lead to a range of issues for rural community banks, such as liquidity challenges, capital erosion, and potential financial distress. As larger financial institutions manage substantial bond portfolios, the interconnectedness of the financial system means that adverse developments in the bond market can reverberate through the broader economy, affecting smaller institutions like rural community banks.To mitigate these risks, rural community banks may need to employ robust risk management strategies, closely monitor their investment portfolios, and stay informed about market conditions. Additionally, regulatory authorities and policymakers play a crucial role in implementing measures to safeguard the stability of the banking sector and protect the interests of rural communities.',
          'author': 'Gina Heeb',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-27',
          'takesTime': '5 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news4.jpg',
          'name':
          'How China Manages Its Currency—and Why That Matters',
          'description':
          'It isn’t just about economics. The yuan has a political and psychological importance too. On the political front, the internationalization of the yuan signifies China\'s growing influence on the global stage. As the yuan becomes more widely used in international trade and finance, it challenges the dominance of traditional reserve currencies, such as the U.S. dollar and the euro.Moreover, the global acceptance of the yuan reflects China\'s ambition to establish itself as a key player in the world economy. This move aligns with the country\'s broader geopolitical strategy, reinforcing its position as a major economic power.Psychologically, the yuan\'s rise also symbolizes a shift in economic power dynamics. It sends a message that China is not just an emerging market but a force to be reckoned with, capable of shaping the future of the global financial system.In essence, the yuan\'s ascent goes beyond financial transactions; it represents a transformative moment in the narrative of global economic leadership, with China at the forefront of this pivotal change.',
          'author': 'Weilun Soon',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-27',
          'takesTime': '6 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news5.jpg',
          'name':
          'Stocks Rise to Start Last Trading Week of Year',
          'description':
          'Major indexes advanced to start the holiday-shortened trading week, with stocks looking to close out a positive year after a bruising 2022. Investors showed optimism as they embraced the potential for economic recovery and the prospect of improved market conditions in the upcoming year. The positive momentum was driven by various factors, including strong corporate earnings, progress in global vaccination efforts, and the anticipation of central banks adopting accommodative policies. As the year draws to a close, market participants are closely monitoring geopolitical developments, economic indicators, and other factors that could influence the financial landscape in the coming months.',
          'author': 'Caitlin Ostroff',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-26',
          'takesTime': '2 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news6.jpg',
          'name':
          'Construction Loans, Like Holiday Guests, Might Hang Around Too Long',
          'description':
          'Banks commercial real estate lending has experienced a growth rate that closely parallels the expansion observed in consumer loans throughout the course of 2023. This phenomenon can be attributed to several key factors that have influenced the dynamics of the real estate market and the financial industry. Here are some reasons behind this concurrent growth: \nEconomic Recovery: The ongoing economic recovery from the challenges posed by previous years has contributed to increased business activities. As businesses expand or initiate new projects, the demand for commercial real estate, such as office spaces, retail outlets, and industrial facilities, rises. Banks respond to this demand by providing loans to finance these ventures. \nLow Interest Rates: Persistently low interest rates have been a driving force behind the surge in both consumer and commercial lending. With borrowing costs being relatively affordable, businesses and individuals are more inclined to seek financing for real estate ventures. This favorable interest rate environment encourages borrowing and investment. \nReal Estate Market Dynamics: Favorable conditions in the real estate market, including increased property values and demand for commercial spaces, make lending in this sector attractive for banks. As property values rise, the collateral for loans becomes more substantial, reducing the risk for lenders.',
          'author': 'Telis Demos',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '3 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news7.jpg',
          'name':
          'Nasdaq Set to Beat NYSE in IPO Race for Fifth Year in a Row',
          'description':
          'U.K. chip designer Arm, which raised \$5.2 billion in the year’s biggest IPO, was among the companies to debut on Nasdaq. The IPO marked a significant milestone for Arm, known for its innovative semiconductor designs and technology, as it gained access to the U.S. public markets through its listing on Nasdaq. The move was part of Arm\'s strategic efforts to expand its global presence and attract a broader investor base. As it joined the ranks of companies trading on Nasdaq, Arm aimed to leverage the increased visibility and liquidity provided by the U.S. stock exchange to support its growth initiatives and capitalize on new opportunities in the dynamic technology sector.',
          'author': 'Alexander Osipovich',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-26',
          'takesTime': '5 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news8.jpg',
          'name':
          'How Food Stocks Spoiled in 2023',
          'description':
          'Companies in the packaged food industry experienced notable underperformance in the U.S. stock market throughout the year. The challenges faced by these companies were diverse, contributing to their lackluster stock performance. However, there is optimism that the upcoming year might bring about improvements and a more positive outlook for the industry.Several factors could have contributed to the underperformance of packaged food stocks. These might include shifts in consumer preferences, increased competition, rising commodity prices affecting input costs, and supply chain disruptions. Changing consumer trends, such as a growing preference for healthier and more sustainable food options, could have impacted the demand for traditional packaged foods.Despite the challenges faced in the past year, there is hope for a better performance in the upcoming year. Companies in the packaged food sector might adapt their strategies to align with changing consumer preferences, invest in innovation, and enhance their supply chain resilience. Additionally, economic recovery and stabilization could positively influence consumer spending on packaged food products.',
          'author': 'Aaron Back',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-26',
          'takesTime': '4 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news9.jpg',
          'name':
          'Credit-Card Spending Piles Up as Savings Dwindle ',
          'description':
          '',
          'author': 'Angel Au-Yeung',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '2 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news10.jpg',
          'name':
          'The Crypto Queen Pulling the Strings at Binance',
          'description':
          'The headline "Credit-Card Spending Piles Up as Savings Dwindle" suggests a concerning trend where individuals are accumulating credit card debt while their savings are decreasing. This situation can have significant financial implications and may indicate challenges in personal financial management. Let\'s break down the key points and considerations related to this headline:Credit Card Spending Increase: \nThe headline implies that there is a surge in credit card spending. This could be due to various reasons, such as increased consumer confidence, economic recovery, or changing spending patterns.\nSavings Decline:\nThe mention of dwindling savings suggests that individuals are drawing down their savings, possibly to support their spending habits. It raises concerns about financial stability and preparedness for unexpected expenses.\nFinancial Stress:\nA simultaneous increase in credit card debt and decrease in savings may indicate financial stress for individuals. Reliance on credit cards for spending while depleting savings can lead to a cycle of debt.',
          'author': 'Angus Berwick',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-24',
          'takesTime': '9 mins'
        });
        // await db.insert('News', {
        //   'imageId': 'assets/news/image/news5.jpg',
        //   'name':
        //   '',
        //   'description':
        //   '',
        //   'author': '',
        //   'authorImage': 'assets/news/author/author1.png',
        //   'date': '2023-12-26',
        //   'takesTime': '2 mins'
        // });
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchIncomeData() async {
    final Database db = await database;
    return await db.query('Income');
  }
}
