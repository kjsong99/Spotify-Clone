package com.song.spotifyback.service;

import com.song.spotifyback.entity.Search;

import java.util.List;

public interface SearchService {
    public void initSequence();
    public List<Search> search(String keyword);
}
