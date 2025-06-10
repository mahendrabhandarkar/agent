package com.plant.agent.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.ai.chat.client.advisor.QuestionAnswerAdvisor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/chat")
public class ChatController {

    public static final Logger logger = LoggerFactory.getLogger(ChatController.class);

    private final ChatClient chatClient;

    private QuestionAnswerAdvisor quesAnsAdvisor;

    public ChatController(@Qualifier("ollamaChatModel") ChatModel chatModel, VectorStore vectorStore) {
        this.quesAnsAdvisor = new QuestionAnswerAdvisor(vectorStore);
        this.chatClient = ChatClient.builder(chatModel).build();
    }

    @GetMapping("/test")
    public String chat() {
    //    .prompt().advisors(quesAnsAdvisor);
        return chatClient.prompt()
                .user("How did the Federal Reserve's recent interest rate cut impact various asset classes according to the analysis")
                .advisors(quesAnsAdvisor)
                .call()
                .content();
    }

    @PostMapping("/test")
    public String chatPost(@RequestParam("txtSrch") String textSrch) {
        //    .prompt().advisors(quesAnsAdvisor);
        logger.info(textSrch);
        return chatClient.prompt()
                .user(textSrch)
                .advisors(quesAnsAdvisor)
                .call()
                .content();
    }

/*
    private final ChatClient chatClient;

    public ChatController(ChatClient.Builder builder, VectorStore vectorStore) {
        this.chatClient = builder
                .defaultAdvisors(new QuestionAnswerAdvisor(vectorStore))
                .build();
    }

    @GetMapping("/")
    public String chat() {
        return chatClient.prompt()
                .user("How did the Federal Reserve's recent interest rate cut impact various asset classes according to the analysis")
                .call()
                .content();
    }
 */
}
