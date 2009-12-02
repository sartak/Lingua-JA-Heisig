package Lingua::JA::Heisig;
use strict;
use warnings;
use utf8;
use 5.008005;
our $VERSION = 0.01;

use Sub::Exporter -setup => {
    exports => [
        qw(kanji),
    ],
    groups => {
        learned => \&_build_learned,
    },
};

do {
    my $kanji;
    sub _kanji {
        if (!$kanji) {
            $kanji = join '', <DATA>;
            $kanji =~ s/\s+//g;
        }

        return $kanji;
    }
};

sub kanji {
    my $kanji = _kanji();
    return wantarray ? split '', $kanji : $kanji;
}

sub _build_learned {
    my $class = shift;
    my $group = shift;
    my $arg   = shift;

    my $up_to = $arg->{up_to} || $ENV{HEISIG_LEARNED};

    my $learned   = substr(_kanji(), 0, $up_to);
    my $unlearned = substr(_kanji(), $up_to);

    my %is_learned = (
        (map { $_ => 1 } split '', $learned),
        (map { $_ => 0 } split '', $unlearned),
    );

    return {
        is_learned => sub { $is_learned{$_[0]} },
        rewrite    => sub {
            my $text = shift;
            my %cb = (
                learned   => sub { $_ },
                unlearned => sub { $_ },
                nonheisig => sub { $_ },
                @_,
            );

            $text =~ s[(\p{Han})][
                local $_ = $1;
                            $is_learned{$_} ? $cb{learned}->()
                  : defined $is_learned{$_} ? $cb{unlearned}->()
                                            : $cb{nonheisig}->()
            ]ge;

            return $text;
        },
    };
}

1;

=head1 NAME

Lingua::JA::Heisig - Utility functions for Heisig's Remembering the Kanji 

=head1 SYNOPSIS


=head1 AUTHOR

Shawn M Moore, C<sartak@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 Shawn M Moore.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

__DATA__

一二三四五六七八九十
口日月田目古吾冒朋明
唱晶品呂昌早旭世胃旦
胆亘凹凸旧自白百中千
舌升昇丸寸専博占上下
卓朝只貝貞員見児元頁
頑凡負万句肌旬勺的首
乙乱直具真工左右有賄
貢項刀刃切召昭則副別
丁町可頂子孔了女好如

母貫兄克小少大多夕汐
外名石肖硝砕砂削光太
器臭妙省厚奇川州順水
氷永泉原願泳沼沖江汁
潮源活消況河泊湖測土
吐圧埼垣圭封涯寺時均
火炎煩淡灯畑災灰点照
魚漁里黒墨鯉量厘埋同
洞胴向尚字守完宣宵安
宴寄富貯木林森桂柏枠

梢棚杏桐植枯朴村相机
本札暦案燥未末沫味妹
朱株若草苦寛薄葉模漠
墓暮膜苗兆桃眺犬状黙
然荻狩猫牛特告先洗介
界茶合塔王玉宝珠現狂
皇呈全栓理主注柱金銑
鉢銅釣針銘鎮道導辻迅
造迫逃辺巡車連軌輸前
各格略客額夏処条落冗

軍輝運冠夢坑高享塾熟
亭京涼景鯨舎周週士吉
壮荘売学覚栄書津牧攻
敗枚故敬言警計獄訂討
訓詔詰話詠詩語読調談
諾諭式試弐域賊栽載茂
成城誠威滅減桟銭浅止
歩渉頻肯企歴武賦正証
政定錠走超赴越是題堤
建延誕礎婿衣裁装裏壊

哀遠猿初布帆幅帽幕幌
錦市姉肺帯滞刺制製転
芸雨雲曇雷霜冬天橋嬌
立泣章競帝童瞳鐘商嫡
適滴敵匕北背比昆皆混
渇謁褐喝旨脂壱毎敏梅
海乞乾腹複欠吹炊歌軟
次茨資姿諮賠培剖音暗
韻識鏡境亡盲妄荒望方
妨坊芳肪訪放激脱説鋭

曽増贈東棟凍妊廷染燃
賓歳県栃地池虫蛍蛇虹
蝶独蚕風己起妃改記包
胞砲泡亀電竜滝豚逐遂
家嫁豪腸場湯羊美洋詳
鮮達羨差着唯焦礁集准
進雑雌準奮奪確午許歓
権観羽習翌曜濯曰困固
国団因姻園回壇店庫庭
庁床麻磨心忘忍認忌志

誌忠串患思恩応意想息
憩恵恐惑感憂寡忙悦恒
悼悟怖慌悔憎慣愉惰慎
憾憶慕添必泌手看摩我
義議犠抹抱搭抄抗批招
拓拍打拘捨拐摘挑指持
括揮推揚提損拾担拠描
操接掲掛研戒械鼻刑型
才財材存在乃携及吸扱
丈史吏更硬又双桑隻護

獲奴怒友抜投没設撃殻
支技枝肢茎怪軽叔督寂
淑反坂板返販爪妥乳浮
将奨採菜受授愛払広拡
鉱弁雄台怠治始胎窓去
法会至室到致互棄育撤
充銃硫流允唆出山拙岩
炭岐峠崩密蜜嵐崎入込
分貧頒公松翁訟谷浴容
溶欲裕鉛沿賞党堂常裳

掌皮波婆披破被残殉殊
殖列裂烈死葬瞬耳取趣
最撮恥職聖敢聴懐慢漫
買置罰寧濁環還夫扶渓
規替賛潜失鉄迭臣姫蔵
臓賢堅臨覧巨拒力男労
募劣功勧努励加賀架脇
脅協行律復得従徒待往
征径彼役徳徹徴懲微街
衡稿稼程税稚和移秒秋

愁私秩秘称利梨穫穂稲
香季委秀透誘穀菌米粉
粘粒粧迷粋糧菊奥数楼
類漆様求球救竹笑笠笹
筋箱筆筒等算答策簿築
人佐但住位仲体悠件仕
他伏伝仏休仮伯俗信佳
依例個健側侍停値倣倒
偵僧億儀償仙催仁侮使
便倍優伐宿傷保褒傑付

符府任賃代袋貸化花貨
傾何荷俊傍久畝囚内丙
柄肉腐座卒傘匁以似併
瓦瓶宮営善年夜液塚幣
弊喚換融施旋遊旅勿物
易賜尿尼泥塀履屋握屈
掘堀居据層局遅漏刷尺
尽沢訳択昼戸肩房扇炉
戻涙雇顧啓示礼祥祝福
祉社視奈尉慰款禁襟宗

崇祭察擦由抽油袖宙届
笛軸甲押岬挿申伸神捜
果菓課裸斤析所祈近折
哲逝誓暫漸断質斥訴昨
詐作雪録尋急穏侵浸寝
婦掃当争浄事唐糖康逮
伊君群耐需儒端両満画
歯曲曹遭漕槽斗料科図
用庸備昔錯借惜措散廿
庶遮席度渡奔噴墳憤焼

暁半伴畔判券巻圏勝藤
謄片版之乏芝不否杯矢
矯族知智矛柔務霧班帰
弓引弔弘強弱沸費第弟
巧号朽誇汚与写身射謝
老考孝教拷者煮著署暑
諸猪渚賭峡狭挟追師帥
官棺管父交効較校足促
距路露跳躍践踏骨滑髄
禍渦過阪阿際障随陪陽

陳防附院陣隊墜降階陛
隣隔隠堕陥穴空控突究
窒窃窪搾窯窮探深丘岳
兵浜糸織繕縮繁縦線締
維羅練緒続絵統絞給絡
結終級紀紅納紡紛紹経
紳約細累索総綿絹繰継
緑縁網緊紫縛縄幼後幽
幾機玄畜蓄弦擁滋慈磁
系係孫懸却脚卸御服命

令零齢冷領鈴勇通踊疑
擬凝範犯厄危宛腕苑怨
柳卵留貿印興酉酒酌酵
酷酬酪酢酔配酸猶尊豆
頭短豊鼓喜樹皿血盆盟
盗温監濫鑑猛盛塩銀恨
根即爵節退限眼良朗浪
娘食飯飲飢餓飾館養飽
既概慨平呼坪評刈希凶
胸離殺純鈍辛辞梓宰壁

避新薪親幸執報叫糾収
卑碑陸睦勢熱菱陵亥核
刻該劾述術寒醸譲壌嬢
毒素麦青精請情晴清静
責績積債漬表俵潔契喫
害轄割憲生星姓性牲産
隆峰縫拝寿鋳籍春椿泰
奏実奉俸棒謹勤漢嘆難
華垂睡錘乗剰今含吟念
琴陰予序預野兼嫌鎌謙

廉西価要腰票漂標栗遷
覆煙南楠献門問閲閥間
簡開閉閣閑聞潤欄闘倉
創非俳排悲罪輩扉侯候
決快偉違緯衛韓干肝刊
汗軒岸幹芋宇余除徐叙
途斜塗束頼瀬勅疎速整
剣険検倹重動勲働種衝
薫病痴痘症疾痢疲疫痛
癖匿匠医匹区枢殴欧抑

仰迎登澄発廃僚寮療彫
形影杉彩彰彦顔須膨参
惨修珍診文対紋蚊斉剤
済斎粛塁楽薬率渋摂央
英映赤赦変跡蛮恋湾黄
横把色絶艶肥甘紺某謀
媒欺棋旗期碁基甚勘堪
貴遺遣舞無組粗租祖阻
査助宜畳並普譜湿顕繊
霊業撲僕共供異翼洪港

暴爆恭選殿井囲耕亜悪
円角触解再講購構溝論
倫輪偏遍編冊典氏紙婚
低抵底民眠捕浦蒲舗補
邸郭郡郊部都郵邦郷響
郎廊盾循派脈衆逓段鍛
后幻司伺詞飼嗣舟舶航
般盤搬船艦艇瓜弧孤繭
益暇敷来気汽飛沈妻衰
衷面革靴覇声呉娯誤蒸

承函極牙芽邪雅釈番審
翻藩毛耗尾宅託為偽長
張帳脹髪展喪巣単戦禅
弾桜獣脳悩厳鎖挙誉猟
鳥鳴鶴烏蔦鳩鶏島暖媛
援緩属嘱偶遇愚隅逆塑
岡鋼綱剛缶陶揺謡就懇
墾免逸晩勉象像馬駒験
騎駐駆駅騒駄驚篤騰虎
虜膚虚戯虞慮劇虐鹿薦

慶麗熊能態寅演辰辱震
振娠唇農濃送関咲鬼醜
魂魔魅塊襲嚇朕雰箇錬
遵罷屯且藻隷癒丹潟丑
卯巳
