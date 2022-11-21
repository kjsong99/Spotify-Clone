package com.song.spotifyback.service.impl;

import com.song.spotifyback.entity.Search;
import com.song.spotifyback.repository.MusicRepository;
import com.song.spotifyback.repository.SearchRepository;
import com.song.spotifyback.service.SearchService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    private final SearchRepository searchRepository;

    @Override
    public void initSequence() {
        searchRepository.initSeq();
    }

    @Override
    public List<Search> search(String keyword) {
        return searchRepository.findAllBy(keyword);
    }
}
