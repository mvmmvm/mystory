class RoomsController < ApplicationController
    def create
        @room = Room.create(story: Story.new, character: Character.new)
        p @room
        redirect_to room_path(@room)
    end

    def show
        p "show開始"
        @room = Room.find(params[:id])
        @chats = Story.find(@room.story.id)
        @players = Player.where(room: @room)
    end

    def chats
        p "---------------------------"
        @room = Room.find(params[:id])
        p @room
        @story = Story.find(@room.story.id)
        p @story
        if @story.all
            p "aru"
            @chats = @story
        else
            p "nai"
            request_gpt(@room, @story)


            # TODO:
            @check_chara = Character.where(story: @story)
            count = 0
            @check_chara.each do |chara|
                if chara.is_criminal
                    count += 1
                end
                if count > 1
                    chara.is_criminal = false
                    chara.save!
                    p "duplicated criminal"
                end
            end
            @room.update(story: @story)
        end
        redirect_to @room
    end

    def validate(content, index)
        p content
        if content.nil?
            ""
        else
            p content[index]
            content[index]
        end
    end

    def request_gpt(room, story)

        name1 = "佐藤佑樹"
        name2 = "御堂拡"
        name3 = "浄明寺遥"
        gender1 = "男性"
        gender2= "男性"
        gender3 = "男性"

        @client = OpenAI::Client.new(
            access_token: "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",
            request_timeout: 600
        )
        @query =
            "[条件]\n"\
            "下記の設定を条件通りに作ってください。"\
            "既に設定があるものについてはそのままにしておいてください。"\
            "「何も知りません」とは言わせないでください。"\
            "#{name1}、#{name2}、#{name3}のうちの１人が高橋信夫を殺害した犯人です。"\
            "高橋信夫を殺害した犯人を１人選んでください。"\
            "人物同士での共謀・協力はさせないでください。"\
            "高橋信夫に秘密はありません。"\
            "高橋信夫に謎の人物は関わっていません。"\
            "秘密の証拠品には人物たちの名前を入れないでください。"\
            "秘密の種類は重複させないでください。"\
            "秘密の内容は重複させないでください。"\
            "秘密の証拠品は必ず設定し、重複させないでください。"\
            "人物たちに、事件前後、他の人物の持つ秘密に関係する情報を知る機会はなかったことにしてください。"\
            "人物たちの職業に警察官、探偵、新聞記者を設定しないでください。"\
            "恋愛関係の秘密の場合、必ずしも男女同士の恋愛関係とは限らないことを考慮してください。"\
            "人物たちには他の人物の秘密を明かさせないでください。"\
            "カメラ映像と指紋はないものとしてください。"\
            "ただし、#{name1}、#{name2}、#{name3}の秘密の種類は下記から一つ選び、すべて別々のものにしてください。"\
            "恋愛/借金/病気や健康状態/精神的な問題/職場でのトラブル/逮捕歴/学歴や資格の詐称/年齢詐称/性的指向/婚歴/子どもの有無/過去の失敗/薬物やアルコールの依存/人間関係のトラブル/不倫/不妊や疾病/身体的な制約/過去の仕事やキャリア/現在の職場での立場/自己の能力やスキルに関する不安/被害経験（いじめ、虐待、暴力など）/過去の自殺未遂/逮捕歴/学業成績/社会的な地位や階級/移民の経験や背景/個人的な信仰や宗教/反社会的なグループや組織への所属/身体的な制約やハンディキャップ/精神的な障害や病気/薬物の使用経験/自己の子供の問題/婚約や結婚の計画/避妊や妊娠に関する情報/悪い交友関係/自身の過去のトラウマ/プライベートな写真や動画/ソーシャルメディアのアカウントや活動/過去の仕事の失敗/家庭内の問題やトラブル/隠れている才能やスキル/職場での人間関係/学歴や学校の成績/ネット上での偽名やアカウント/秘密のプロジェクトや計画/自身の身体的な問題/自己の恐怖や不安/自身の欲望や夢/自身の弱点や欠点/他人からの評価や批判/人前での行動や言動/学校や職場での評価/自己の過去の失敗や過ち\n\n"\
            "[設定]：\n"\
            "事件の舞台：\n"\
            "事件：殺人\n"\
            "犯行場所：\n"\
            "犯行時刻：\n"\
            "凶器：\n"\
            "被害者の名前：高橋信夫\n"\
            "高橋信夫の性別：\n"\
            "高橋信夫の性格：\n"\
            "高橋信夫の職業：\n"\
            "#{name1}の性別：#{gender1}\n"\
            "#{name1}の性格：\n"\
            "#{name1}の職業：\n"\
            "#{name1}のここにいる理由と、具体的な自身の秘密の内容と、秘密を隠すため、事件直前に取った行動を独白させてください：「」「\n"\
            "#{name1}の秘密の種類：\n"\
            "#{name1}の秘密の証拠品：\n"\
            "#{name1}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること１を独白させてください：「」「」\n"\
            "#{name1}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること２を独白させてください：「」\n"\
            "#{name1}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること３を独白させてください：「」\n"\
            "#{name2}の性別：#{gender2}\n"\
            "#{name2}の性格：\n"\
            "#{name2}の職業：\n"\
            "#{name2}のここにいる理由と、具体的な自身の秘密の内容と、秘密を隠すため、事件直前に取った行動を独白させてください：「」\n"\
            "#{name2}の秘密の種類：\n"\
            "#{name2}の秘密の証拠品：\n"\
            "#{name2}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること１を独白させてください：「」\n"\
            "#{name2}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること２を独白させてください：「」：\n"\
            "#{name2}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること３を独白させてください：「」\n"\
            "#{name3}の性別：#{gender3}\n"\
            "#{name3}の性格：\n"\
            "#{name3}の職業：\n"\
            "#{name3}のここにいる理由と、具体的な自身の秘密の内容と、秘密を隠すため、事件直前に取った行動を独白させてください：「」\n"\
            "#{name3}の秘密の種類：\n"\
            "#{name3}の秘密の証拠品：\n"\
            "#{name3}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること１を独白させてください：「」\n"\
            "#{name3}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること２を独白させてください：「」\n"\
            "#{name3}が事件後に他の人物に聞いたり現場を調べてわかったことか他の人物の行動に関すること３を独白させてください：「」\n"\
            "#{name1}の行動が他の人物から言及されている件について、理由を独白させてください：「」\n"\
            "#{name2}の行動が他の人物から言及されている件について、理由を独白させてください：「」\n"\
            "#{name3}の行動が他の人物から言及されている件について、理由を独白させてください：「」\n"\
            "#{name1}、#{name2}、#{name3}のうち高橋信夫を殺害した犯人は誰ですか：\n"\
            "その人物が高橋信夫を殺害した理由について独白させてください：「」"

        p @query

        response = @client.chat(
        parameters: {
            frequency_penalty: 0,
            messages: [
                { role: "user", content: @query }
            ],
            model: "gpt-3.5-turbo-16k",
            presence_penalty: 0,
            temperature: 1,
            top_p: 1
        })
        p response

        @chats = response.dig("choices", 0, "message", "content")

        p @chats

        @set =  validate(@chats.match(/舞台(：|:|は)\s{0,1}(.+)/), 2)
        @body = validate(@chats.match(/ストーリー(：|:|は)\s{0,1}(.+)/), 2)
        @weapon = validate(@chats.match(/凶器(：|:|は)\s{0,1}(.+)/) , 2)
        @place = validate(@chats.match(/犯行場所(：|:|は)\s{0,1}(.+)/), 2)
        @time = validate(@chats.match(/犯行時刻(：|:|は)\s{0,1}(.+)/), 2)
        @victim = validate(@chats.match(/被害者の名前(：|:|は)\s{0,1}(.+)/), 2)
        @v_gender =  validate(@chats.match(/高橋信夫の性別(：|:|は)\s{0,1}(.+)/), 2)
        @v_personality =  validate(@chats.match(/高橋信夫の性格(：|:|は)\s{0,1}(.+)/), 2)
        @v_job = validate(@chats.match(/高橋信夫の職業(：|:|は)\s{0,1}(.+)/), 2)
        @criminal = validate(@chats.match(/(人物(1|１)|#{name1})、(人物(2|２)|#{name2})、(人物(3|３)|#{name3})のうち.+犯人.*(：|:|は)\s{0,1}(.+)/), 8)
        story.update(
            name: "ストーリー#{story.id}",
            set: @set,
            body: @body,
            weapon: @weapon,
            place: @place,
            time: @time,
            victim: @victim,
            v_gender: @v_gender,
            v_personality: @v_personality,
            v_job: @v_job,
            all: @chats
        )
        @evidence = []

        # @characters = Character.where(story: story)

        # if @characters
        #     @characters.destroy_all
        # end

        [name1, name2, name3].each_with_index do |name, count|
            count += 1
            p count
            fw_count = count.to_s.tr("A-Z0-9","Ａ-Ｚ０-９")
            p fw_count
            @gender = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の性別(：|:|は)\s{0,1}(.+)/), 4)
            p @gender
            @personality =  validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の性格(：|:|は)\s{0,1}(.+)/), 4)
            p @personality
            @job = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の職業(：|:|は)\s{0,1}(.+)/), 4)
            p @job
            @introduce = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})のここにいる理由.+独白させてください(：|:|)\s{0,1}(.+)/), 4)
            p @introduce
            @secret = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の秘密の種類(：|:|は)\s{0,1}(.+)/), 4)
            p @secret
            @stuff = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の秘密の証拠品(：|:|は)\s{0,1}(.+)/), 4)
            p @stuff
            @evidence = [
                validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})が.+(１|1).+独白させてください(：|:|)\s{0,1}(.+)/), 5),
                validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})が.+(２|2).+独白させてください(：|:|)\s{0,1}(.+)/), 5),
                validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})が.+(３|3).+独白させてください(：|:|)\s{0,1}(.+)/), 5)
            ]
            @reason = validate(@chats.match(/(人物(#{fw_count}|#{count})|#{name})の行動が他の人物から.+独白させてください(：|:|)\s{0,1}(.+)/), 4)
            p @evidence
            p @reason
            p @criminal

            @identification = [count.to_s, fw_count, name]
            p @identification
            p @identification.any? { |i| @criminal.include?(i) }
            if @identification.any? { |i| @criminal.include?(i) }
                @is_criminal = true
            else
                @is_criminal = false
            end


            @character = Character.create(
                story: story,
                name: name,
                gender: @gender,
                personality: @personality,
                job: @job,
                introduce: @introduce,
                secret: @secret,
                stuff: @stuff,
                evidence: @evidence,
                reason: @reason,
                is_criminal: @is_criminal
            )
            Player.create(
                character: @character,
                room: room,
                name: name
            )
        end
    end

end
