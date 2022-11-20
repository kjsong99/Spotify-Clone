package com.song.spotifyback.controller;

import com.song.spotifyback.entity.Album;
import com.song.spotifyback.entity.Search;
import com.song.spotifyback.repository.SearchRepository;
import com.song.spotifyback.service.impl.AlbumServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/search")
public class SearchController {

    @Autowired
    private final SearchRepository searchRepository;

    @ResponseBody
    @RequestMapping()
    public ResponseEntity<List<Search>> searchByKeyword(@RequestParam ("keyword") String keyword){
        System.out.println(keyword);
        return ResponseEntity.ok(this.searchRepository.findAllBy(keyword));
    }
}
